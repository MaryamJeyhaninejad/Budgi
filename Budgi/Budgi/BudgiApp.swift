//
//  BudgiApp.swift
//  Budgi
//
//  Created by Maryam Jeyhaninejad on 17/12/24.
//

import SwiftUI

@main
struct BudgiApp: App {
    @State private var showSplashScreen = true

    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                ContentView()
                    .environmentObject(DashboardViewModel())
            }
        }
    }
}
