//
//  LoginView.swift
//  LiftWell
//
//  Created by Evan Slaney on 5/8/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @Binding var currentShowingView: String
    @AppStorage("uid") var userID: String = ""
    @Binding var currentShowingMain: Bool
    @State var firestoreReference = Firestore.firestore()
    @EnvironmentObject var user: User

    func loginSetUser(user: User) {
        self.user.setUser(other: user)
    }
    
    var body: some View {
        VStack {
            Text("LiftWell")
                .foregroundStyle(.purple.gradient)
                .font(.custom("GillSans-SemiboldItalic", size: 72))
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .font(.custom("GillSans-SemiboldItalic", size: 32))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.purple))
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .font(.custom("GillSans-SemiboldItalic", size: 32))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.purple))
                .padding()
            Button {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        //Incorrect password alert
                        print(error)
                        return
                    }
                    if let authResult = authResult {
                        withAnimation {
                            userID = authResult.user.uid
                            currentShowingMain = false
                        }
                    }
                    firestoreReference.collection("users").getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                if document.data()["userID"] as! String == userID {
                                    let userID: String = document.data()["userID"] as! String
                                    let name: String = document.data()["name"] as! String
                                    let email: String = document.data()["email"] as! String
                                    let gender: Gender = Gender(rawValue: document.data()["gender"] as! String)!
                                    let age: Int = document.data()["age"] as! Int
                                    let workouts: [Workout] = document.data()["workouts"] as! [Workout]
                                    let friends: [Friend] = document.data()["friends"] as! [Friend]
                                    user.setUser(other: User(userID: userID, name: name, email: email, gender: gender, age: age, workouts: workouts, friends: friends))
                                }
                            }
                        }
                    }
                    
                  
                }
            } label: {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.custom("GillSans-SemiboldItalic", size: 32))
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            Button {
                withAnimation {
                    self.currentShowingView = "signup"
                }
            } label: {
                Text("Don't have an account?")
                    .font(.custom("GillSans-SemiboldItalic", size: 18))
                    .tint(.purple)
            }
        }
    }
}
