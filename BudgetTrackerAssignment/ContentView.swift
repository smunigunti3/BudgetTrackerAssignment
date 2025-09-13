//
//  ContentView.swift
//  BudgetTracker
//
//  Created by Rik Roy on 8/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = BudgetViewModel()
    @State private var expenseName = ""
    @State private var expenseAmount = ""
    @State private var showAmountError: Bool = false
    @State private var amountError: String?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    // MARK: - Budget Header
                    Text("Budget Tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // TODO: Show remaining budget here
                    // Note: Budget can change color in certain cases
                    let leftoverBudget = viewModel.remainingBudget.formatted(.number.precision(.fractionLength(2)))
                    Text("Remaining: $\(leftoverBudget)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(viewModel.budgetColor)
                    
                    
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                // MARK: - Add Expense Form
                VStack(spacing: 15) {
                    
                    // TODO: TextField for expense name
                    TextField(
                        "Expense name",
                        text: $expenseName
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // TODO: TextField for expense amount
                    TextField(
                        "Amount",
                        text: $expenseAmount
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button {
                        // TODO: Add expense and remember to clear the fields
                        if let amount = Double(expenseAmount) {
                            viewModel.addExpense(name: expenseName, amount: amount)
                            expenseName = ""
                            expenseAmount = ""
                            showAmountError = false
                            amountError = nil
                        } else {
                            showAmountError = true
                            amountError = "Please enter a valid number"
                        }
                        
                        
                    } label: {
                        Text("Add Expense")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                            )
                            .foregroundStyle(.white)
                        
                    }
                    .alert(isPresented: $showAmountError) {
                        Alert(
                            title: Text("Invalid Amount"),
                            message: Text(amountError ?? "Unknown error"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                // MARK: - Expenses List
                VStack(alignment: .leading, spacing: 10) {
                    Text("Expenses")
                        .font(.headline)
                    
                    // TODO: If there are no expenses, show "No expenses yet"
                    if viewModel.expenses.isEmpty {
                        Text("No expenses yet")
                            .foregroundColor(.secondary)
                            .italic()
                    }
                                                            
                    ForEach($viewModel.expenses) { $expense in
                        // TODO: Wrap each expense in a NavigationLink
                        // Destination should be ExpenseDetailView(expense: $expense, viewModel: viewModel)
                        
                        // Inside the row, display:
                        // - Expense name
                        // - Expense amount
                        // - A delete button
                        
                        NavigationLink(destination: ExpenseDetailView(expense: $expense, viewModel: viewModel)) {
                            
                            Text(expense.name)
                            
                            Spacer()
                            
                            let formattedExpenseAmount: String = String(format: "%.2f", expense.amount)
                            Text("$\(formattedExpenseAmount)")
                            
                            Button(action: {
                                viewModel.removeExpense(expense: expense)
                            }) {
                                Text("Delete")
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                Spacer()
            }
            .padding()
        }
        .padding()
        .navigationTitle("Budget Tracker")
    }
}

#Preview {
    ContentView()
}
