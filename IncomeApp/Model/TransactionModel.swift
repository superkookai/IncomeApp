//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 15/1/2568 BE.
//

import Foundation

struct Transaction: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let type: TransactionType
    let amount: Double
    let date: Date
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
//        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self.date)
    }
    
    var displayAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: NSNumber(value: self.amount)) ?? ""
    }
}
