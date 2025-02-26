//
//  Currency.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 26/2/2568 BE.
//

import Foundation

enum Currency: String, CaseIterable, Identifiable {
    case usd, pounds
    
    var title: String {
        switch self {
        case .usd: return "USD"
        case .pounds: return "Pounds"
        }
    }
    
    var id: Self {
        self
    }
    
    var locale: Locale {
        switch self {
        case .usd:
            return Locale(identifier: "en_US")
        case .pounds:
            return Locale(identifier: "en_GB")
        }
    }
}
