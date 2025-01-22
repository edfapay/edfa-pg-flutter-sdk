//
//  EdfaPaySdkEventChannels.swift
//  edfapay_sdk
//
//  Created by Zohaib Kambrani on 02/03/2023.
//

import Foundation
import Flutter
import UIKit



public class EdfaPaySdkEventChannels: NSObject{
    
    var cardpay:FlutterEventChannel? = nil;
    var cardDetailPay:FlutterEventChannel? = nil;
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

        cardpay = FlutterEventChannel(name: "com.edfapg.flutter.sdk.cardpay", binaryMessenger: messenger)
        cardDetailPay = FlutterEventChannel(name: "com.edfapg.flutter.sdk.cardDetailPay", binaryMessenger: messenger)
        applepay = FlutterEventChannel(name: "com.edfapg.flutter.sdk.applepay", binaryMessenger: messenger)
        
        sale = FlutterEventChannel(name: "com.edfapg.flutter.sdk.sale", binaryMessenger: messenger)
        recurringSale = FlutterEventChannel(name: "com.edfapg.flutter.sdk.recurringsale", binaryMessenger: messenger)
        capture = FlutterEventChannel(name: "com.edfapg.flutter.sdk.capture", binaryMessenger: messenger)
        creditVoid = FlutterEventChannel(name: "com.edfapg.flutter.sdk.creditvoid", binaryMessenger: messenger)
        transactionStatus = FlutterEventChannel(name: "com.edfapg.flutter.sdk.transactionstatus", binaryMessenger: messenger)
        transactionDetail = FlutterEventChannel(name: "com.edfapg.flutter.sdk.transactiondetail", binaryMessenger: messenger)
        transactionLogs = FlutterEventChannel(name: "com.edfapg.flutter.sdk.transactionlogs", binaryMessenger: messenger)
        
        
        
        cardpay?.setStreamHandler(CardPayEventHandler())
        cardDetailPay?.setStreamHandler(CardDetailPayEventHandler())
        applepay?.setStreamHandler(ApplePayEventHandler())
        
        sale?.setStreamHandler(SaleEventHandler())
        recurringSale?.setStreamHandler(RecurringSaleEventHandler())
        capture?.setStreamHandler(CaptureEventHandler())
        creditVoid?.setStreamHandler(CreditVoidEventHandler())
        transactionDetail?.setStreamHandler(TransactionDetailEventHandler())
        transactionStatus?.setStreamHandler(TransactionStatusEventHandler())

    }
    
}

