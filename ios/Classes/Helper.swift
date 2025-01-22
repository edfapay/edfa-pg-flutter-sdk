//
//  Helper.swift
//  edfapg_sdk
//
//  Created by ZIK on 21/01/2025.
//

import Foundation
import EdfaPgSdk


func designTypeFrom(code:String) -> EdfaPayDesignType{
    if(code == "one"){
        return .one
    }
    
    if(code == "two"){
        return .two
    }
    
    if(code == "three"){
        return .three
    }
    
    return .one
}


func languageFrom(code:String) -> EdfaPayLanguage{
    if(code == "en"){
        return .en
    }
    
    if(code == "ar"){
        return .ar
    }
    
    return .en
}
