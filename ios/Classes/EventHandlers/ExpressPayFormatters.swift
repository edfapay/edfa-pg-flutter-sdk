//
//  ExpressPayFormatters.swift
//  expresspay_sdk
//
//  Created by Zohaib Kambrani on 03/03/2023.
//

import Foundation
import ExpressPaySDK

final class ExpressPayDateFormatter {

    private let birthdateFormat = DateFormatter()

    init() {
        birthdateFormat.locale = .init(identifier: "us")
        birthdateFormat.dateFormat = "yyyy-MM-dd"
    }
    
    func toDate(dob: String?) -> Date? {
        guard let birthdate =  dob else { return nil }
        return birthdateFormat.date(from: birthdate)
    }
    
    func toString(dob: Date?) -> String? {
        guard let birthdate =  dob else { return nil }
        return birthdateFormat.string(from: birthdate)
    }
}
