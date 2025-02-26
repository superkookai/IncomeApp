//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 15/1/2568 BE.
//

import Foundation
import SwiftData

@Model
class TransactionModel {
    var id: UUID
    var title: String
    var type: TransactionType
    var amount: Double
    var date: Date
    
    init(id: UUID, title: String, type: TransactionType, amount: Double, date: Date) {
        self.id = id
        self.title = title
        self.type = type
        self.amount = amount
        self.date = date
    }
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
//        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self.date)
    }
    
    func displayAmount(currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: NSNumber(value: self.amount)) ?? ""
    }
}

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
    
    func displayAmount(currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: NSNumber(value: self.amount)) ?? ""
    }
}
