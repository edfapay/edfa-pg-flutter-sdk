import Flutter
import UIKit
import ExpressPaySDK
import PassKit

fileprivate let events:ExpressPaySDKEventChannels = ExpressPaySDKEventChannels()
fileprivate let methods:ExpresspaySdkMethodChannels = ExpresspaySdkMethodChannels()

public class ExpresspaySdkPlugin: NSObject, FlutterPlugin, PKPaymentAuthorizationViewControllerDelegate{
    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        if let flutterViewController = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController{            
            events.initiate(with: flutterViewController)
            methods.initiate(with: flutterViewController)
        }
        
        registrar.addMethodCallDelegate(ExpresspaySdkPlugin(), channel: methods.expressPaySdk!)
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == methods.methodGetPlatformVersion{
            getPlatformVersion(call, result: result)
        }else if call.method == methods.methodConfig{
            config(call, result: result)
        }
    }
    
    func apple(viewController:UIViewController){
        let request = PKPaymentRequest()
        request.countryCode = "SA"
        request.currencyCode = "SAR"
        request.merchantIdentifier = ""
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.supportedNetworks = [.visa]
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Test", amount: 1.0)]
        if let payvc = PKPaymentAuthorizationViewController(paymentRequest: request){
            payvc.delegate = self
            viewController.present(payvc, animated: true)
        }
    }
}


extension ExpresspaySdkPlugin{
    
    private func getPlatformVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult){
      result("iOS " + UIDevice.current.systemVersion)
    }
    
}



extension ExpresspaySdkPlugin{
    
    private func config(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        if let params = call.arguments as? [Any],
           let key = params[0] as? String,
           let pass = params[1] as? String,
           let enableDebug = params[2] as? Bool{
            
            let credentials = ExpressPayCredential(
                clientKey: key, clientPass: pass,
                paymentUrl: "https://api.expresspay.sa/post"
            )
            
            if enableDebug{
                ExpressPaySDK.enableLogs()
            }
            ExpressPaySDK.config(credentials)
        }
    }
    
}

