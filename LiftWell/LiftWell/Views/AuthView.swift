//
//  AuthView.swift
//  LiftWell
//
//  Created by Evan Slaney on 5/8/23.
//

import SwiftUI

struct AuthView: View {
    @State private var currentShowingView: String = "login" // login or signup
    @Binding var currentShowingMain: Bool
    
    var body: some View {
        
        if currentShowingView == "login" {
            LoginView(currentShowingView: $currentShowingView, currentShowingMain: $currentShowingMain)
                .transition(.move(edge: .leading))
        } else {
            CreateAccountView(currentShowingView: $currentShowingView, currentShowingMain: $currentShowingMain)
                .transition(.move(edge: .trailing))
        }
    }
}

