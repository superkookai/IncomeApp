//
//  SettingsView.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 26/2/2568 BE.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("orderDecending") var orderDecending: Bool = false
    @AppStorage("currency") var currency: Currency = .usd
    @AppStorage("filterMinimum") var filterMinimum: Double = 0
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = currency.locale
        formatter.numberStyle = .currency
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $orderDecending) {
                    Text("Order \(orderDecending ? "(Lateset)" : "(Earliest)")")
                        .font(.title2)
                }
                
                Picker("Currency", selection: $currency) {
                    ForEach(Currency.allCases) { currency in
                        Text(currency.title)
                    }
                }
                .font(.title2)
                
                HStack {
                    Text("Filter minimum:")
                    TextField("", value: $filterMinimum, formatter: numberFormatter)
                        .multilineTextAlignment(.trailing)
                }
                .font(.title2)
                
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
