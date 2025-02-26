//
//  IncomeAppApp.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 15/1/2568 BE.
//

import SwiftUI
import SwiftData

@main
struct IncomeAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: TransactionModel.self)
        }
    }
}
