//
//  SplashScreenView.swift
//  Budgi
//
//  Created by Maryam Jeyhaninejad on 17/12/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 950, height: 950)
               
            }
        }
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(DashboardViewModel())
}
