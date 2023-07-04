//
//  HomeView.swift
//  LiftWell
//
//  Created by Oscar Herrera on 5/8/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct HomeView: View {
    
    @AppStorage("uid") var userID: String = ""
    @Binding var currentShowingMain: Bool
    @State var firestoreReference = Firestore.firestore()
    @EnvironmentObject var user: User
    let dateHolder: DateHolder = DateHolder()
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                
                Group {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 3)
                            .foregroundStyle(.purple.gradient)
                        HStack {
                            Image(systemName: "figure.strengthtraining.traditional")
                            Text("Welcome back, \(user.name)")
                            Image(systemName: "figure.strengthtraining.traditional")
                        }
                        .foregroundColor(.white)
                    }
                    .frame(width: 365, height: 60)
                    .shadow(radius: 10)
                    Spacer()
                }
                .font(.custom("GillSans-SemiboldItalic", size: 28))
                
                NavigationLink(destination: CalenderView().environmentObject(dateHolder)){
                    HStack {
                        Group{ Text("Calendar")
                            Image(systemName: "calendar")
                        }
                        .foregroundStyle(.purple.gradient)
                        .font(.custom("GillSans-SemiboldItalic", size: 40))
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: ExerciseView()){
                    HStack {
                        Group{ Text("Exercises")
                            Image(systemName: "dumbbell.fill")
                        }
                        .foregroundStyle(.purple.gradient)
                        .font(.custom("GillSans-SemiboldItalic", size: 40))
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: QuickWorkoutView()
                    .environmentObject(user)){
                    HStack {
                        Group{ Text("Quick Workout")
                            Image(systemName: "dumbbell.fill")
                        }
                        .foregroundStyle(.purple.gradient)
                        .font(.custom("GillSans-SemiboldItalic", size: 40))
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: FriendView()){
                    HStack() {
                        
                        Group{ Text("Friends")
                            Image(systemName: "person.fill")
                        }
                        .foregroundStyle(.purple.gradient)
                        .font(.custom("GillSans-SemiboldItalic", size: 40))
                        
                    }
                }
                
                Spacer()
                
                Button {
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                        withAnimation {
                            self.userID = ""
                            currentShowingMain = true
                        }
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                    
                } label: {
                    Text("Sign Out")
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
            }
            
        }
        
    }
}

