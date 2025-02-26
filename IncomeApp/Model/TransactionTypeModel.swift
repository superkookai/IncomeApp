//
//  TransactionTypeModel.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 15/1/2568 BE.
//

import Foundation

enum TransactionType: String, CaseIterable, Identifiable, Codable {
    case income
    case expense
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
