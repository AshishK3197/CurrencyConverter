//
//  ContentView.swift
//  Currency Converter
//
//  Created by Ashish Kumar on 24/03/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var currencies = ["SGD","MYR","EUR","USD","AUD","JPY","CNH","HKD","CAD","INR","DKK","GBP","RUB","NZD","MXN","IDR","TWD","THB","VND"]
    @State var fromSelectedCurrency = 0
    @State var toSelectedCurrency = 0
    @State var sliderValue: Double = 1.0
    @State var alertIsVisible = false
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("calculate_background").resizable().edgesIgnoringSafeArea(.all)
                VStack {
                    Picker(selection: $fromSelectedCurrency, label: Text("From").bold()) {
                        ForEach(0..<currencies.count){
                            Text(self.currencies[$0]).bold()
                        }
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                    Picker(selection: $toSelectedCurrency, label: Text("To").bold()) {
                        ForEach(0..<currencies.count){
                            Text(self.currencies[$0]).bold()
                        }
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                    VStack {
                        HStack{
                            Text("Amount:")
                            Spacer()
                            Text("\(String(format: "%.1f", sliderValue.rounded()))")
                        }.padding()
                        
                        HStack {
                            Text("1")
                            Slider(value: $sliderValue, in: 1...100)
                            Text("100")
                        }.padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Convert Pressed")
                        self.alertIsVisible = true
                        let roundedValue = Int(self.sliderValue.rounded())
                        self.networkManager.makeUrl(fromCurrency: self.currencies[self.fromSelectedCurrency], toCurrency: self.currencies[self.toSelectedCurrency], amount: roundedValue)
                        print(self.currencies[self.fromSelectedCurrency])
                        print(self.currencies[self.toSelectedCurrency])
                        print(roundedValue)
                    }) {
                        Text("Convert")
                            .font(.system(size: 25))
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                            .padding(.horizontal)
                    }
                    .alert(isPresented: $alertIsVisible) { () -> Alert in
                        return Alert(title: Text("Result"), message: Text("The converted value is \(String(describing: self.networkManager.conversionRate))"), dismissButton: .default(Text("Okay")))
                    }
                }
            }.navigationBarTitle("Currency Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






