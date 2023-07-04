//
//  LiftWellApp.swift
//  LiftWell
//
//  Created by Evan Slaney on 5/8/23.
//

import SwiftUI
import FirebaseCore

@main
struct LiftWellApp: App {
    @EnvironmentObject var user: User
    
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(User(userID: "", name: "", email: "", gender: Gender.Male, age: 0, workouts: [], friends: []))
        }
    }
}
