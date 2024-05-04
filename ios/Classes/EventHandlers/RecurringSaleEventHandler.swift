//
//  SaleEventHandler.swift
//  edfapay_sdk
//
//  Created by Zohaib Kambrani on 03/03/2023.
//

import Foundation
import Flutter
import UIKit
import EdfaPgSdk


class RecurringSaleEventHandler : NSObject, FlutterStreamHandler{
    
    var eventSink:FlutterEventSink? = nil
    
    private lazy var recurringAdapter: EdfaPgRecurringSaleAdapter = {
        let adapter = EdfaPgAdapterFactory().createRecurringSale()
        adapter.delegate = self
        return adapter
    }()
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        
        if let params = arguments as? [String:Any],
           let auth = params["auth"] as? Bool,
           let payerEmail = params["payerEmail"] as? String,
           let cardNumber = params["cardNumber"] as? String,
           let order = params["EdfaPgOrder"] as? [String : Any?],
           let recurringOptions =  params["EdfaPgRecurringOptions"] as? [String : Any?]{
                 
            recurringAdapter.delegate = self
            recurringAdapter.execute(
                order: EdfaPgOrder.from_(dictionary: order),
                options: EdfaPgRecurringOptions.from(dictionary: recurringOptions),
                payerEmail: payerEmail,
                cardNumber: cardNumber,
                auth: auth,
                callback: handleResponse
            )
            
        }
        
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    private func handleResponse(response: EdfaPgResponse<EdfaPgSaleResult>){
        
        switch response {
        case .result(let result):
            
            switch result {
            case .recurring(let result):
                let json = result.toJSON(root: "recurring")
                eventSink?(json)
                
            case .secure3d(let result):
                let json = result.toJSON(root: "secure3d")
                eventSink?(json)
                
            case .redirect(let result):
                let json = result.toJSON(root: "redirect")
                eventSink?(json)
                
            case .success(let result):
                let json = result.toJSON(root: "success")
                eventSink?(json)
                
            case .decline(let result):
                let json = result.toJSON(root: "decline")
                eventSink?(json)

            default: break
                let json = ["failure" : ["error" : "Unhandled response case at EdfaPaySaleResult.result"]]
                eventSink?(json)
                
            }
                        
        case .error(let error):
            let json = ["error" : error.json()]
            eventSink?(json)
            print(error)
            
        case .failure(let exception):
            if let err = exception as? NSError{
                let json = ["failure" : err.userInfo]
                eventSink?(json)
            }else{
                let json = ["failure" : ["exception" : exception.localizedDescription]]
                eventSink?(json)
            }
            print(exception)
            
        default:
            let json = ["failure" : ["error" : "Unhandled response case at EdfaPayResponse.result"]]
            eventSink?(json)
        }
    }

}


extension RecurringSaleEventHandler : EdfaPgAdapterDelegate{
    
    func willSendRequest(_ request: EdfaPgDataRequest) {
        
    }
    
    func didReceiveResponse(_ reponse: EdfaPgDataResponse?) {
        if let data = reponse?.data,
           let dict = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed){
            eventSink?(["responseJSON" : dict])
        }
    }
    
}
