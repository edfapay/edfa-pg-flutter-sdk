//
//  EdfaPaySdkEventChannels.swift
//  EdfaPaySdk
//
//  Created by Zohaib Kambrani on 02/03/2023.
//

import Foundation
import Flutter
import UIKit
import EdfaPgSdk


public class EdfapaySdkMethodChannels: NSObject{
    var edfaPaySdk:FlutterMethodChannel? = nil;

    final let methodGetPlatformVersion = "getPlatformVersion";
    final let methodConfig = "config";

    public func initiate(with flutterViewController: FlutterViewController){
        
        let messenger = flutterViewController.binaryMessenger
        
        edfaPaySdk = FlutterMethodChannel(name: "com.edfapg.flutter.sdk", binaryMessenger: messenger)
    }
    
}

