//
//  DashboardViewModel.swift
//  Budgi
//
//  Created by Maryam Jeyhaninejad on 17/12/24.
//

import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var balance: Double = 4500
    @Published var income: Double = 2500
    @Published var expenses: Double = 2000
    @Published var transactions: [Transaction] = []

    func addTransaction(amount: Double, category: String, details: String, isIncome: Bool) {
        // Add the new transaction
        let transaction = Transaction(amount: amount, category: category, details: details, isIncome: isIncome)
        transactions.append(transaction)
        
        // Update income/expenses
        if isIncome {
            income += amount
        } else {
            expenses += amount
        }

        // Recalculate balance
        balance = income - expenses
    }
}

struct Transaction {
    var amount: Double
    var category: String
    var details: String
    var isIncome: Bool
}
