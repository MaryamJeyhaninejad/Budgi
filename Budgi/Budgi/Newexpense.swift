//
//  Newexpense.swift
//  Budgi
//
//  Created by Maryam Jeyhaninejad on 17/12/24.
//

import SwiftUI

struct Newexpense: View {
    @EnvironmentObject var dashboardViewModel: DashboardViewModel // Access shared data
    @State private var amount: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedCategory: String? = nil
    @State private var details: String = ""
    @State private var isButtonClicked: Bool = false
    @State private var isIncome: Bool = false


    var categories = [
            ("house.fill", "Home"),
            ("book.fill", "Education"),
            ("graduationcap.fill", "School"),
            ("cart.fill", "Shopping"),
            ("car.fill", "Transport"),
            ("gift.fill", "Gift"),
            ("fork.knife", "Food"),
            ("heart.fill", "Health"),
            ("smiley.fill", "Fun"),
            ("ellipsis", "More")
        ]
    
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.doesRelativeDateFormatting = true
            return formatter
        }
    
var body: some View {
    VStack(spacing: 20) {
        
        HStack {
            Text("How much?")
                .font(.callout)
                .foregroundColor(.primary)
            Spacer()
        }
        HStack {
            Text("€")
                .font(.headline)
                .padding(.leading, 20)
            
            ZStack(alignment: .leading) {
                if amount.isEmpty {
                    Text("Enter amount")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 5)
                }
                TextField("", text: $amount)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
            }
        }
        
        .frame(height: 44)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        
        HStack {
                        Text("When?")
                .font(.callout)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    HStack {
                        Button(action: {
                            if let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) {
                                selectedDate = previousDay
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.buttonColor)
                                .padding(.leading,15)
                        }

                        Text(dateFormatter.string(from: selectedDate))
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Button(action: {
                            if let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) {
                                                    selectedDate = nextDay
                                                }
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.buttonColor)
                                .padding(.trailing, 15)
                        }
                    }
                    .frame(height: 44)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
        HStack {
            Text("Category")
                .font(.callout)
                .foregroundColor(.primary)
            Spacer()
        }

        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 15) {
            ForEach(categories, id: \.0) { (icon, name) in
                Button(action: {
                    selectedCategory = name
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(selectedCategory == name ? Color.blue.opacity(0.2) : Color(UIColor.systemGray6))
                            .frame(width: 50, height: 50)

                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(selectedCategory == name ? .buttonColor : .primary)
                    }
                }
            }
        }
        HStack {
                       Text("Details (optional)")
                .font(.callout)
                           .foregroundColor(.primary)
                       Spacer()
                   }

                   HStack {
                       ZStack(alignment: .leading) {
                           if details.isEmpty {
                               Text("e.g. Dinner out at sushi")
                                   .frame(height: 44)
                                   .foregroundColor(.gray)
                                   .padding(.horizontal, 5)
                           }
                           TextField("", text: $details)
                               .padding(.horizontal, 10)
                               .padding(.vertical, 8)
                       }
                   }
                   .background(Color(UIColor.systemGray6)) // Light gray background
                   .cornerRadius(10)
                   .overlay(
                       RoundedRectangle(cornerRadius: 10)
                           .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Border
                   )
                   .frame(height: 44)
        Spacer()
        
        Toggle("Is this an Income?", isOn: $isIncome)

        // Add Button
        Button(action: {
            if let amountValue = Double(amount), let category = selectedCategory {
                dashboardViewModel.addTransaction(amount: amountValue, category: category, details: details, isIncome: isIncome)
            }
        }) {
            Text("Add")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background((!amount.isEmpty && selectedCategory != nil) ? Color.blue : Color.gray)
                .cornerRadius(10)
                .padding(.horizontal, 15)
        }
                    .disabled(amount.isEmpty || selectedCategory == nil)
                    .opacity(amount.isEmpty || selectedCategory == nil ? 0.5 : 1.0)
 
    }
    .padding()
    .navigationTitle("Add New Expense")
    .navigationBarTitleDisplayMode(.inline)
    
}
}

#Preview {
NavigationStack {
    Newexpense()
        .environmentObject(DashboardViewModel())
}

}
