//
//  ExpressPaySDKEventChannels.swift
//  expresspay_sdk
//
//  Created by Zohaib Kambrani on 02/03/2023.
//

import Foundation
import Flutter
import UIKit
import ExpressPaySDK


public class ExpresspaySdkMethodChannels: NSObject{
    var expressPaySdk:FlutterMethodChannel? = nil;

    final let methodGetPlatformVersion = "getPlatformVersion";
    final let methodConfig = "config";

    public func initiate(with flutterViewController: FlutterViewController){
        
        let messenger = flutterViewController.binaryMessenger
        
        expressPaySdk = FlutterMethodChannel(name: "com.expresspay.sdk", binaryMessenger: messenger)
    }
    
}

