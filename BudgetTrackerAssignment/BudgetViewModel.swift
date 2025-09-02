//
//  BudgetViewModel.swift
//  BudgetTracker
//
//  Created by Rik Roy on 8/21/25.
//

import SwiftUI

@Observable class BudgetViewModel {
    var expenses: [Expense] = []
    
    var remainingBudget: Double {
        // TODO: Calculate the remaining budget
        // Hint: Start with 500.0 and subtract the sum of all expense amounts
        return 0.0
    }
    
    var budgetColor: Color {
        // TODO: Return .green if remainingBudget > 0, otherwise .red
        return .green
    }
    
    func addExpense(name: String, amount: Double) {
        // TODO: Create a new Expense and add it to the expenses array
    }
    
    func removeExpense(expense: Expense) {
        // TODO: Find the index of the given expense and remove it from the array
    }
}
