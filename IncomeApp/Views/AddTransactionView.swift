//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 15/1/2568 BE.
//

import SwiftUI

struct AddTransactionView: View {
    var transactionToEdit: Transaction?
    @State private var amount: Double = 0
    @State private var title: String = ""
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var isAlertPresented: Bool = false
    
    @Binding var transactions: [Transaction]
    
    @Environment(\.dismiss) var dismiss
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        return formatter
    }
    
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .light))
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
            
            Rectangle()
                .fill(Color(uiColor: .lightGray))
                .frame(height: 0.5)
                .padding(.horizontal,30)
            
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { type in
                    Text(type.title)
                        .tag(type)
                }
            }
            
            TextField("Title", text: $title)
                .font(.system(size: 20))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal,30)
                .autocorrectionDisabled()
                .autocapitalization(.sentences)
            
            Button {
                createOrEditTransaction()
            } label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
                    .font(.system(size: 20,weight: .semibold))
                    .foregroundStyle(transactionToEdit == nil ? .white : .black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(transactionToEdit == nil ? .primaryLightGreen : .primaryLightGreen.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 10))
            }
            .padding(.top)
            .padding(.horizontal,30)
            
            Spacer()
        }
        .padding(.top)
        .alert(alertTitle, isPresented: $isAlertPresented) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            if let transactionToEdit {
                amount = transactionToEdit.amount
                selectedTransactionType = transactionToEdit.type
                title = transactionToEdit.title
            }
        }
    }
    
    func createOrEditTransaction() {
        guard title.count >= 2 else {
            alertTitle = "Title too short"
            alertMessage = "Title must be at least 2 characters long"
            isAlertPresented = true
            return
        }
        
        let transaction = Transaction(title: title, type: selectedTransactionType, amount: amount, date: .now)
        
        if let transactionToEdit, let index = transactions.firstIndex(of: transactionToEdit) {
            transactions[index] = transaction
        } else {
            transactions.append(transaction)
        }
        
        dismiss()
    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
