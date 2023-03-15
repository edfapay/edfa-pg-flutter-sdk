//
//  SaleEventHandler.swift
//  expresspay_sdk
//
//  Created by Zohaib Kambrani on 03/03/2023.
//

import Foundation
import Flutter
import UIKit
import ExpressPaySDK


class CardPayEventHandler : NSObject, FlutterStreamHandler{
    
    var eventSink:FlutterEventSink? = nil
    
    private lazy var saleAdapter: ExpressPaySaleAdapter = {
        let adapter = ExpressPayAdapterFactory().createSale()
        adapter.delegate = self
        return adapter
    }()
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        
        if let params = arguments as? [String:Any],
           let order = params["ExpresspaySaleOrder"] as? [String : Any?],
           let payer =  params["ExpresspayPayer"] as? [String : Any?]{
            
                let order = ExpressPaySaleOrder.from(dictionary: order)
                let payer = ExpressPayPayer.from(dictionary: payer)
            
            // The precise way to present by sdk it self
            var cardDetailVC:UIViewController?
            cardDetailVC = ExpressCardPay()
                .set(order: order)
                .set(payer: payer)
                .on(transactionFailure: { result, error in
                    debugPrint("native.transactionFailure.result ==> \(String(describing: result))")
                    debugPrint("native.transactionFailure.error ==> \(String(describing: error))")
                    
                    cardDetailVC?.dismiss(animated: true)
                    self.handleFailure(error: error)
                    
                })
                .on(transactionSuccess: { res, data in
                    debugPrint("native.transactionSuccess.response ==> \(String(describing: res))")
                    debugPrint("native.transactionSuccess.data ==> \(String(describing: data))")
                    
                    cardDetailVC?.dismiss(animated: true)
                    self.handleSuccess(response: data as! ExpressPayGetTransactionDetailsSuccess)

                }).initialize(
                    target: UIApplication.currentViewController()!,
                    onError: { err in
                        self.handleFailure(error: err)

                    },
                    onPresent: onPresent
                )
            
        }
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    private func onPresent(){
        debugPrint("onPresent :)")
        eventSink?(["onPresent" : ":)"])
    }
    
    private func handleSuccess(response: ExpressPayGetTransactionDetailsSuccess){
        debugPrint("native.transactionSuccess.data ==> \(response.toJSON(root: "success"))")
        eventSink?(response.toJSON(root: "success"))
    }
    
    private func handleFailure(error:Any){
        if let e = error as? ExpressPayError{
            eventSink?(["error" : e.json()])
        }else if let e = error as? Encodable{
            eventSink?(e.toJSON(root: "failure"))
        }else{
            let error = [
                "result" : "ERROR",
                "error_code" : 100000,
                "error_message" : "\(error)",
                "errors" : [],
            ] as [String : Any]
            eventSink?(["error":error])
        }
    }
    
}

extension CardPayEventHandler : ExpressPayAdapterDelegate{
    
    func willSendRequest(_ request: ExpressPayDataRequest) {
        
    }
    
    func didReceiveResponse(_ reponse: ExpressPayDataResponse?) {
        
    }
    
}


