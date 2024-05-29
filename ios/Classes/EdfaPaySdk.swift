import Flutter
import UIKit
import EdfaPgSdk
import PassKit

fileprivate let events:EdfaPaySdkEventChannels = EdfaPaySdkEventChannels()
fileprivate let methods:EdfapaySdkMethodChannels = EdfapaySdkMethodChannels()

fileprivate let PAYMENT_URL = "https://api.edfapay.com/payment/post"
public class EdfaPgSdkPlugin: NSObject, FlutterPlugin, PKPaymentAuthorizationViewControllerDelegate{
    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        if let flutterViewController = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController{            
            events.initiate(with: flutterViewController)
            methods.initiate(with: flutterViewController)
        }
        
        registrar.addMethodCallDelegate(EdfaPgSdkPlugin(), channel: methods.edfaPaySdk!)
        
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


extension EdfaPgSdkPlugin{
    private func getPlatformVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult){
      result("iOS " + UIDevice.current.systemVersion)
    }
    
}



extension EdfaPgSdkPlugin{
    private func config(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        if let params = call.arguments as? [Any],
           let key = params[0] as? String,
           let pass = params[1] as? String,
           let enableDebug = params[2] as? Bool{
            
            let credentials = EdfaPgCredential(
                clientKey: key, clientPass: pass,
                paymentUrl: PAYMENT_URL
            )
            
            if enableDebug{
                EdfaPgSdk.enableLogs()
            }
            EdfaPgSdk.config(credentials)
        }
    }
    
}

