//
//  Codables.swift
//  edfapay_sdk
//
//  Created by Zohaib Kambrani on 03/03/2023.
//

import Foundation
import EdfaPgSdk



extension EdfaPgSaleOrder{
    static func from(dictionary:[String:Any?]) -> EdfaPgSaleOrder{
        return EdfaPgSaleOrder(
            id: dictionary["id"] as? String ?? "",
            amount: dictionary["amount"] as? Double ?? 0.0,
            currency: dictionary["currency"] as? String ?? "",
            description: dictionary["description"] as? String ?? ""
        )
    }
}

extension EdfaPgOrder{
    static func from_(dictionary:[String:Any?]) -> EdfaPgOrder{
        return EdfaPgOrder(
            id: dictionary["id"] as? String ?? "",
            amount: dictionary["amount"] as? Double ?? 0.0,
            description: dictionary["description"] as? String ?? ""
        )
    }
}

extension EdfaPgPayer{
    static func from(dictionary:[String:Any?]) -> EdfaPgPayer{
        
        return EdfaPgPayer(
            firstName:  dictionary["firstName"] as? String ?? "",
            lastName: dictionary["lastName"] as? String ?? "",
            address: dictionary["address"] as? String ?? "",
            country: dictionary["country"] as? String ?? "",
            city: dictionary["city"] as? String ?? "",
            zip: dictionary["zip"] as? String ?? "",
            email: dictionary["email"] as? String ?? "",
            phone: dictionary["phone"] as? String ?? "",
            ip: dictionary["ip"] as? String ?? "",
            options: EdfaPgPayerOptions.from(dictionary: dictionary["options"] as? [String : Any?])
        )
    }
}


extension EdfaPgPayerOptions{
    static func from(dictionary:[String:Any?]?) -> EdfaPgPayerOptions?{
        if let s = dictionary{
            return EdfaPgPayerOptions(
               middleName: s["middleName"] as? String ?? "",
               birthdate:EdfaPayDateFormatter().toDate(dob: s["birthdate"] as? String),
               address2: s["address2"] as? String ?? "",
               state: s["state"] as? String ?? ""
           )
        }
        return nil
        
    }
}


extension EdfaPgRecurringOptions{
    static func from(dictionary:[String:Any?]) -> EdfaPgRecurringOptions{
        return EdfaPgRecurringOptions(
           firstTransactionId: dictionary["firstTransactionId"] as? String ?? "",
           token: dictionary["token"] as? String ?? ""
       )
    }
}

extension EdfaPgCard{
    static func from(dictionary:[String:Any?]) -> EdfaPgCard{
        return EdfaPgCard(
            number: dictionary["number"] as? String ?? "",
            expireMonth: dictionary["expireMonth"] as? Int ?? 0,
            expireYear:  dictionary["expireYear"] as? Int ?? 0,
            cvv: dictionary["cvv"] as? String ?? ""
        )
    }
}
