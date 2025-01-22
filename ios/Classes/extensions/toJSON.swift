//
//  Encodables.swift
//  edfapay_sdk
//
//  Created by Zohaib Kambrani on 03/03/2023.
//

import Foundation
import EdfaPgSdk


extension Encodable{
    func toJSON(root:String? = nil) ->  [String: Any]?{
        if let data = try? JSONEncoder().encode(self){
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let _root = root{
                    return [_root : json]
                }
                return json
            }
        }
        
        if let _root = root{
            return [_root : self]
        }
        
        
        return ["error" : self]
    }
}


extension EdfaPgError{
    func json() -> [String: Any]?{
        if var j = toJSON(){
            j["error"] = j["exactErrors"] ?? []
            return j
        }
        return nil
    }
}


// MARK: UIApplication extensions
extension UIApplication {

    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return currentViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}

extension UIWindow {
    func topMostViewController() -> UIViewController? {
        guard let rootViewController = self.rootViewController else {
            return nil
        }
        return topViewController(for: rootViewController)
    }
    
    func topViewController(for rootViewController: UIViewController?) -> UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        guard let presentedViewController = rootViewController.presentedViewController else {
            return rootViewController
        }
        switch presentedViewController {
        case is UINavigationController:
            let navigationController = presentedViewController as! UINavigationController
            return topViewController(for: navigationController.viewControllers.last)
        case is UITabBarController:
            let tabBarController = presentedViewController as! UITabBarController
            return topViewController(for: tabBarController.selectedViewController)
        default:
            return topViewController(for: presentedViewController)
        }
    }
}
