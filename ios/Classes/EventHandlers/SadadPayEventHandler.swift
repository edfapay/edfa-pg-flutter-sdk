
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


class SadadPayEventHandler : NSObject, FlutterStreamHandler{
    
    var eventSink:FlutterEventSink? = nil
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        debugPrint("native.SadadPayEventHandler.onListen")

        if let params = arguments as? [String:Any]{
            
            let orderId = (params["orderId"] as? String)
            let orderDescription = (params["orderDescription"] as? String)
            let amount = (params["amount"] as? Double) ?? 0.0
            let customerName = (params["customerName"] as? String)
            let mobileNumber = (params["mobileNumber"] as? String)
            EdfaSadadPay()
                .setOrderId(orderId ?? "")
                .setOrderDescription(orderDescription ?? "")
                .setOrderAmount(amount)
                .setCustomerName(customerName ?? "")
                .setMobileNumber(mobileNumber ?? "")
                .onSuccess { response in
                    debugPrint("native.onSuccess.response ==> \(String(describing: response.toJSON(root: "success")))")
                    self.eventSink?(response.toJSON(root: "success"))
                }.onFailure { pgErrors, exception in
                    print("Exception: \(exception)")
                    debugPrint("native.onFailure.errors ==> \(String(describing: pgErrors.toJSON(root: "failure")))")
                    self.eventSink?(pgErrors.toJSON(root: "failure"))
                }.initialize { errors in
                    debugPrint("native.initialize.errors ==> \(String(describing: errors.toJSON(root: "error")))")
                    self.eventSink?(errors.toJSON(root: "error"))
                }
            
        }
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    
}

