//
//  Codables.swift
//  expresspay_sdk
//
//  Created by Zohaib Kambrani on 03/03/2023.
//

import Foundation
import ExpressPaySDK



extension ExpressPaySaleOrder{
    static func from(dictionary:[String:Any?]) -> ExpressPaySaleOrder{
        return ExpressPaySaleOrder(
            id: dictionary["id"] as? String ?? "",
            amount: dictionary["amount"] as? Double ?? 0.0,
            currency: dictionary["currency"] as? String ?? "",
            description: dictionary["description"] as? String ?? ""
        )
    }
}

extension ExpressPayOrder{
    static func from_(dictionary:[String:Any?]) -> ExpressPayOrder{
        return ExpressPayOrder(
            id: dictionary["id"] as? String ?? "",
            amount: dictionary["amount"] as? Double ?? 0.0,
            description: dictionary["description"] as? String ?? ""
        )
    }
}

extension ExpressPayPayer{
    static func from(dictionary:[String:Any?]) -> ExpressPayPayer{
        
        return ExpressPayPayer(
            firstName:  dictionary["firstName"] as? String ?? "",
            lastName: dictionary["lastName"] as? String ?? "",
            address: dictionary["address"] as? String ?? "",
            country: dictionary["country"] as? String ?? "",
            city: dictionary["city"] as? String ?? "",
            zip: dictionary["zip"] as? String ?? "",
            email: dictionary["email"] as? String ?? "",
            phone: dictionary["phone"] as? String ?? "",
            ip: dictionary["ip"] as? String ?? "",
            options: ExpressPayPayerOptions.from(dictionary: dictionary["options"] as? [String : Any?])
        )
    }
}


extension ExpressPayPayerOptions{
    static func from(dictionary:[String:Any?]?) -> ExpressPayPayerOptions?{
        if let s = dictionary{
            return ExpressPayPayerOptions(
               middleName: s["middleName"] as? String ?? "",
               birthdate: ExpressPayDateFormatter().toDate(dob: s["birthdate"] as? String),
               address2: s["address2"] as? String ?? "",
               state: s["state"] as? String ?? ""
           )
        }
        return nil
        
    }
}


extension ExpressPayRecurringOptions{
    static func from(dictionary:[String:Any?]) -> ExpressPayRecurringOptions{
        return ExpressPayRecurringOptions(
           firstTransactionId: dictionary["firstTransactionId"] as? String ?? "",
           token: dictionary["token"] as? String ?? ""
       )
    }
}

extension ExpressPayCard{
    static func from(dictionary:[String:Any?]) -> ExpressPayCard{
        return ExpressPayCard(
            number: dictionary["number"] as? String ?? "",
            expireMonth: dictionary["expireMonth"] as? Int ?? 0,
            expireYear:  dictionary["expireYear"] as? Int ?? 0,
            cvv: dictionary["cvv"] as? String ?? ""
        )
    }
}
