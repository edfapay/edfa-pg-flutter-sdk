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


class CardDetailPayEventHandler : NSObject, FlutterStreamHandler{
    
    var eventSink:FlutterEventSink? = nil
    
    private lazy var saleAdapter: EdfaPgSaleAdapter = {
        let adapter = EdfaPgAdapterFactory().createSale()
        adapter.delegate = self
        return adapter
    }()
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events

        if let params = arguments as? [String:Any],
           let order = params["EdfaPgSaleOrder"] as? [String : Any?],
           let payer =  params["EdfaPgPayer"] as? [String : Any?],
           let card =  params["EdfaPgCard"] as? [String : Any?]{
            
            
            let order = EdfaPgSaleOrder.from(dictionary: order)
            let payer = EdfaPgPayer.from(dictionary: payer)
            let card = EdfaPgCard.from(dictionary: card)
            
            
            let languageCode = (params["EdfaPayLanguage"] as? String) ?? "en"
            let language = languageFrom(code: languageCode)

            let recurring = (params["recurringInit"] as? Bool) ?? false

            
    
            // The precise way to present by sdk it self
            EdfaPayWithCardDetails(viewController: UIApplication.currentViewController()!)
                .set(order: order)
                .set(payer: payer)
                .set(card: card)
                .set(language: language)
                .set(recurring: recurring)
                .on(transactionFailure: { result, error in
                    debugPrint("native.transactionFailure.result ==> \(String(describing: result))")
                    debugPrint("native.transactionFailure.error ==> \(String(describing: error))")
                    
                    self.handleFailure(error: error ?? "Error")
                    
                })
                .on(transactionSuccess: { res, data in
                    debugPrint("native.transactionSuccess.response ==> \(String(describing: res))")
                    debugPrint("native.transactionSuccess.data ==> \(String(describing: data))")
                    
                    self.handleSuccess(response: data as! EdfaPgGetTransactionDetailsSuccess)

                }).initialize(
                    onError: { err in
                        self.handleFailure(error: err)

                    }
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
    
    private func handleSuccess(response: EdfaPgGetTransactionDetailsSuccess){
        debugPrint("native.transactionSuccess.data ==> \(String(describing: response.toJSON(root: "success")))")
        eventSink?(response.toJSON(root: "success"))
    }
    
    private func handleFailure(error:Any){
        
        
        if let e = error as? Array<String>{
            let error = [
                "result" : "ERROR",
                "error_code" : 100000,
                "error_message" : "\(error)",
                "errors" : e.map({ eMsg in
                    return [
                        "code" : 100000,
                        "message" : eMsg
                    ]
                }),
            ] as [String : Any]
            eventSink?(["error":error])
            return
        }
        
        if let e = error as? EdfaPgError{
            eventSink?(["error" : e.json()])
            return
        }
        
        if let e = error as? Encodable{
            eventSink?(e.toJSON(root: "failure"))
            return
        }
        
        let error = [
            "result" : "ERROR",
            "error_code" : 100000,
            "error_message" : "\(error)",
            "errors" : [
                "code" : 100000,
                "message" : "\(error)"
            ],
        ] as [String : Any]
        eventSink?(["error":error])
    }
    
}

extension CardDetailPayEventHandler : EdfaPgAdapterDelegate{
    
    func willSendRequest(_ request: EdfaPgDataRequest) {
        
    }
    
    func didReceiveResponse(_ reponse: EdfaPgDataResponse?) {
        
    }
    
}


