//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Ashish Kumar on 25/03/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject{
    
    @Published var currencyValue = [Value]()
    
    let baseurl = "http://apilayer.net/api/live?access_key=5c4f2e3cdf2f54e0c88801273ffd5204&currencies="
    
    func makeUrl(fromCurrency: String , toCurrency: String , amount: Int){
        let formattedUrl = "\(baseurl)\(toCurrency)&source=\(fromCurrency)&format=\(amount)"
        performRequest(passUrl: formattedUrl)
    }
    
    func performRequest(passUrl: String){
        if let finalUrl = URL(string: passUrl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: finalUrl) { (data, response, error) in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do {
                            let decodedData = try decoder.decode(CurrencyData.self, from: safeData)
                            print(decodedData)
                            DispatchQueue.main.async {
                                self.currencyValue = [decodedData.quotes]
                                print(self.currencyValue[0].USDINR)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}
