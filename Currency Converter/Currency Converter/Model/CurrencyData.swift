//
//  CurrencyData.swift
//  Currency Converter
//
//  Created by Ashish Kumar on 24/03/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

struct CurrencyData : Decodable{
    let quotes : Value
}

struct Value : Decodable, Identifiable{
    var id: String?
    let USDINR : Double
}

