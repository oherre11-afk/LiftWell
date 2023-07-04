//
//  ContentView.swift
//  LiftWell
//
//  Created by Evan Slaney on 5/8/23.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    @AppStorage("uid") var userID: String = ""
    @State var currentShowingMain: Bool = true
    
    var body: some View {
        if currentShowingMain {
            AuthView(currentShowingMain: $currentShowingMain)
                .transition(.move(edge: .leading))
        } else {
            HomeView(currentShowingMain: $currentShowingMain)
                .transition(.move(edge: .trailing))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
