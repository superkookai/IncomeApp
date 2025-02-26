//
//  TransactionRowView.swift
//  IncomeApp
//
//  Created by Weerawut Chaiyasomboon on 15/1/2568 BE.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: TransactionModel
    
    @AppStorage("currency") var currency: Currency = .usd
    
    var body: some View {
        VStack {
            HStack {
                Text(transaction.displayDate)
                    .font(.system(size: 14))
            }
            .padding(.vertical,5)
            .frame(maxWidth: .infinity)
            .background(.lightGrayShade.opacity(0.5))
            .clipShape(.rect(cornerRadius: 5))
            
            HStack {
                Image(systemName: transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(transaction.type == .income ? .green : .red)
                
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Text(transaction.title)
                            .font(.system(size: 15, weight: .bold))
                        
                        Spacer()
                        
                        //String(format: "%.2f", transaction.amount)
                        Text(transaction.displayAmount(currency: currency))
                            .font(.system(size: 15, weight: .bold))
                    }
                    
                    Text("Completed")
                        .font(.system(size: 14))
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}


#Preview {
    TransactionRowView(transaction: TransactionModel(id: UUID(), title: "Apple", type: .expense, amount: 120.25, date: .now))
}
