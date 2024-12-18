//
//  ContentView.swift
//  Budgi
//
//  Created by Maryam Jeyhaninejad on 17/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dashboardViewModel: DashboardViewModel // Access shared data
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    Text("Dashboard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                HStack(spacing: 10) {
                    VStack {
                        Text("Balance")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("\(dashboardViewModel.balance, specifier: "%.2f")€")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    VStack {
                        Text("Income")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("\(dashboardViewModel.income, specifier: "%.2f")€")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    VStack {
                        Text("Expenses")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("\(dashboardViewModel.expenses, specifier: "%.2f")€")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(10)
                .background(Color(red: 0.81, green: 0.82, blue: 0.94))
                .cornerRadius(12)
                .frame(maxHeight:100)
                .padding(.horizontal, 15)
                
                
                
                
                HStack(spacing: 20) {
                    HStack(spacing: 40) {
                        MemojiCard(maryam: "maryam")
                        MemojiCard(maryam: "ali")
                    }
                }
                .padding(.horizontal)
                
                CalendarView()
                Spacer()
                
                CustomTabBar()
                
            }
        }
    }
}

struct MemojiCard: View {
    var maryam : String
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemGray6))
                
                Image(maryam)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
            
            // Button(action: {
            //   print("Button tapped")
            NavigationLink(destination: Newexpense()) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
            }
            .frame(width: 30, height: 30)
            .background(Color .buttonColor)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            .padding(.top, 10)
        }
    }
}
struct CustomTabBar: View {
    @State private var selectedTab: String = "Dashboard"
    
    var body: some View {
        HStack {
            Spacer()
            
            TabBarItem(
                title: "Dashboard",
                systemImageName: "house.fill",
                isSelected: selectedTab == "Dashboard", // Check if this tab is selected
                onTap: { selectedTab = "Dashboard" } // Update selectedTab on tap
            )
            Spacer()
            TabBarItem(
                title: "Report",
                systemImageName: "doc.text",
                isSelected: selectedTab == "Report",
                onTap: { selectedTab = "Report" }
            )
            Spacer()
            TabBarItem(
                title: "Saving",
                systemImageName: "archivebox.fill",
                isSelected: selectedTab == "Saving",
                onTap: { selectedTab = "Saving" }
            )
            Spacer()
            TabBarItem(
                title: "Settings",
                systemImageName: "gearshape.fill",
                isSelected: selectedTab == "Settings",
                onTap: { selectedTab = "Settings" }
            )
            Spacer()
        }
        .frame(height: 60)
        .background(Color(UIColor.systemGray6))
    }
}

struct TabBarItem: View {
    let title: String
    let systemImageName: String
    let isSelected: Bool
    let onTap: () -> Void
    var body: some View {
        VStack {
            Image(systemName: systemImageName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(isSelected ? .buttonColor : .primary)
            Text(title)
                .font(.caption)
                .foregroundColor(isSelected ? .buttonColor : .primary)
        }
        .onTapGesture {
            onTap()
        }
    }
}

struct CalendarView: View {
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("Previous Month")
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.buttonColor)
                }
                Spacer()
                Text("October 2024")
                    .font(.headline)
                Spacer()
                Button(action: {
                    print("Next Month")
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.buttonColor)
                }
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                ForEach(1..<32, id: \.self) { day in
                    Button(action: {
                        print("Day \(day) selected")
                    }) {
                        Text("\(day)")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(8)
                            .background(day == 10 || day == 30 ? (Color(red: 0.81, green: 0.82, blue: 0.94)) : Color.clear)
                            .clipShape(Circle())
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DashboardViewModel())
}
