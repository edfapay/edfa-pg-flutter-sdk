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


class SaleEventHandler : NSObject, FlutterStreamHandler{
    
    var eventSink:FlutterEventSink? = nil
    
    private lazy var saleAdapter: EdfaPgSaleAdapter = {
        let adapter = EdfaPgAdapterFactory().createSale()
        adapter.delegate = self
        return adapter
    }()
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        
        if let params = arguments as? [String:Any],
           let auth = params["auth"] as? Bool,
           let order = params["EdfaPgSaleOrder"] as? [String : Any?],
           let card = params["EdfaPgCard"] as? [String : Any?],
           let payer =  params["EdfaPgPayer"] as? [String : Any?]{
                 
            saleAdapter.delegate = self
            saleAdapter.execute(
                order: EdfaPgSaleOrder.from(dictionary: order),
                card: EdfaPgCard.from(dictionary: card),
                payer: EdfaPgPayer.from(dictionary: payer),
                termUrl3ds: "https://expresspay.sa",
                options: nil,
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

extension SaleEventHandler : EdfaPgAdapterDelegate{
    
    func willSendRequest(_ request: EdfaPgDataRequest) {
        
    }
    
    func didReceiveResponse(_ reponse: EdfaPgDataResponse?) {
        if let data = reponse?.data,
           let dict = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed){
            eventSink?(["responseJSON" : dict])
        }
    }
    
}


