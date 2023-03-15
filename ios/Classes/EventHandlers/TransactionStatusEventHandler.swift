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


class TransactionStatusEventHandler : NSObject, FlutterStreamHandler{
    
    var eventSink:FlutterEventSink? = nil
    
    private lazy var saleAdapter: ExpressPaySaleAdapter = {
        let adapter = ExpressPayAdapterFactory().createSale()
        adapter.delegate = self
        return adapter
    }()
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
}

extension TransactionStatusEventHandler : ExpressPayAdapterDelegate{
    
    func willSendRequest(_ request: ExpressPayDataRequest) {
        
    }
    
    func didReceiveResponse(_ reponse: ExpressPayDataResponse?) {
        
    }
    
}
