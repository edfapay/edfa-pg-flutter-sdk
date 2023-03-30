//
//  ExpressPaySDKEventChannels.swift
//  expresspay_sdk
//
//  Created by Zohaib Kambrani on 02/03/2023.
//

import Foundation
import Flutter
import UIKit



public class ExpressPaySDKEventChannels: NSObject{
    
    var cardpay:FlutterEventChannel? = nil;
    var applepay:FlutterEventChannel? = nil;
    
    var sale:FlutterEventChannel? = nil;
    var recurringSale:FlutterEventChannel? = nil;
    var capture:FlutterEventChannel? = nil;
    var creditVoid:FlutterEventChannel? = nil;
    var transactionStatus:FlutterEventChannel? = nil;
    var transactionDetail:FlutterEventChannel? = nil;
    var transactionLogs:FlutterEventChannel? = nil;

    
    public func initiate(with flutterViewController: FlutterViewController) {
        
        let messenger = flutterViewController.binaryMessenger
        
        cardpay = FlutterEventChannel(name: "com.expresspay.sdk.cardpay", binaryMessenger: messenger)
        applepay = FlutterEventChannel(name: "com.expresspay.sdk.applepay", binaryMessenger: messenger)
        
        sale = FlutterEventChannel(name: "com.expresspay.sdk.sale", binaryMessenger: messenger)
        recurringSale = FlutterEventChannel(name: "com.expresspay.sdk.recurringsale", binaryMessenger: messenger)
        capture = FlutterEventChannel(name: "com.expresspay.sdk.capture", binaryMessenger: messenger)
        creditVoid = FlutterEventChannel(name: "com.expresspay.sdk.creditvoid", binaryMessenger: messenger)
        transactionStatus = FlutterEventChannel(name: "com.expresspay.sdk.transactionstatus", binaryMessenger: messenger)
        transactionDetail = FlutterEventChannel(name: "com.expresspay.sdk.transactiondetail", binaryMessenger: messenger)
        transactionLogs = FlutterEventChannel(name: "com.expresspay.sdk.transactionlogs", binaryMessenger: messenger)
        
        
        
        cardpay?.setStreamHandler(CardPayEventHandler())
        applepay?.setStreamHandler(ApplePayEventHandler())
        
        sale?.setStreamHandler(SaleEventHandler())
        recurringSale?.setStreamHandler(RecurringSaleEventHandler())
        capture?.setStreamHandler(CaptureEventHandler())
        creditVoid?.setStreamHandler(CreditVoidEventHandler())
        transactionDetail?.setStreamHandler(TransactionDetailEventHandler())
        transactionStatus?.setStreamHandler(TransactionStatusEventHandler())

    }
    
}

