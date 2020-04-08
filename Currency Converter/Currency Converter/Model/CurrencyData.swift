//
//  CurrencyData.swift
//  Currency Converter
//
//  Created by Ashish Kumar on 24/03/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

struct CurrencyConversionResponse: Decodable {
    
    var success: Bool?
    var terms, privacy: String?
    var timestamp: Int?
    var source: String?
    var quotes: Quotes?
}

struct Quotes: Decodable {

    var conversionRate: Double?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.conversionRate = try! container.decode([String:Double].self).first?.value
    }
}
