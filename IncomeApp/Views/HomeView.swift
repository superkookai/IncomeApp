//
//  HomeView.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 15/1/2568 BE.
//

import SwiftUI

struct HomeView: View {
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type: .expense, amount: 120.25, date: .now),
        Transaction(title: "Banana", type: .income, amount: 77.6, date: .now.addingTimeInterval(-86400)),
        Transaction(title: "Orange", type: .expense, amount: 120.25, date: .now.addingTimeInterval(-86400*3))
    ]
    
    @State private var showEditTransaction: Bool = false
    @State private var transactionToEdit: Transaction? = nil
    
    @State private var totalExpenses: Double = 0
    @State private var totalIncome: Double = 0
    @State private var totalBalance: Double = 0
    
    @State private var showSettings: Bool = false
    
    @AppStorage("orderDecending") var orderDecending: Bool = false
    @AppStorage("currency") var currency: Currency = .usd
    @AppStorage("filterMinimum") var filterMinimum: Double = 0
    
    var totalExpensesDisplay: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: NSNumber(value: self.totalExpenses)) ?? ""
    }
    
    var totalIncomeDisplay: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: NSNumber(value: self.totalIncome)) ?? ""
    }
    
    var totalBalanceDisplay: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: NSNumber(value: self.totalBalance)) ?? ""
    }
    
    var displayTransactions: [Transaction] {
        let filterMinimumTransactions = transactions.filter({$0.amount >= filterMinimum})
        let sortedTransactions = orderDecending ? filterMinimumTransactions.sorted(by: {$0.date > $1.date}) : filterMinimumTransactions.sorted(by: {$0.date < $1.date})
        return sortedTransactions
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    
                    List {
                        ForEach(displayTransactions) { transaction in
                            Button {
                                transactionToEdit = transaction
                            } label: {
                                TransactionRowView(transaction: transaction)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
                
                FloatingButton()
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: { transaction in
                AddTransactionView(transactionToEdit: transaction, transactions: $transactions)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showSettings, content: {
                SettingsView()
            })
            .onAppear {
                self.totalExpenses = transactions.filter{ $0.type == .expense}.reduce(0) { $0 + $1.amount }
                self.totalIncome = transactions.filter{ $0.type == .income}.reduce(0) { $0 + $1.amount }
                self.totalBalance = totalIncome - totalExpenses
            }
            .onChange(of: self.transactions) {
                self.totalExpenses = transactions.filter{ $0.type == .expense}.reduce(0) { $0 + $1.amount }
                self.totalIncome = transactions.filter{ $0.type == .income}.reduce(0) { $0 + $1.amount }
                self.totalBalance = totalIncome - totalExpenses
            }
        }
        .tint(.primaryLightGreen)
    }
    
    func delete(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
    
    func FloatingButton() -> some View {
        VStack {
            Spacer()
            
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
            }
            .background(.primaryLightGreen)
            .clipShape(.circle)
        }
    }
    
    func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.primaryLightGreen)
            
            VStack(alignment: .leading,spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(.white)
                        
                        Text(totalBalanceDisplay)
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        Text(totalExpensesDisplay)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        Text(totalIncomeDisplay)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    
}

#Preview {
    HomeView()
}

