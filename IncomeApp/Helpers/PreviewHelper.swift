//
//  PreviewHelper.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 26/2/2568 BE.
//

import Foundation
import SwiftData

class PreviewHelper {
    
    @MainActor
    static let previewContainer: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for: TransactionModel.self, configurations: config)
            container.mainContext.insert(TransactionModel(id: UUID(), title: "Buy McDonald", type: .expense, amount: 5, date: .now))
            container.mainContext.insert(TransactionModel(id: UUID(), title: "Buy Fruits", type: .expense, amount: 5, date: .distantPast))
            container.mainContext.insert(TransactionModel(id: UUID(), title: "Buy Pencils", type: .expense, amount: 7.5, date: .distantPast))
            container.mainContext.insert(TransactionModel(id: UUID(), title: "Code refactor", type: .income, amount: 15, date: .now))
            container.mainContext.insert(TransactionModel(id: UUID(), title: "Buy iPhone", type: .expense, amount: 500, date: .distantFuture))
            return container
        } catch {
            fatalError("Failed to create model container") //this function make no need to return nil
        }
    }()
}
