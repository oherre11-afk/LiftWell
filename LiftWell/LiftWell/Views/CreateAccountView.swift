//
//  CreateAccountView.swift
//  LiftWell
//
//  Created by Evan Slaney on 5/8/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CreateAccountView: View {
    @State var email: String = ""
    @State var password: String = ""
    @Binding var currentShowingView: String
    @AppStorage("uid") var userID: String = ""
    @Binding var currentShowingMain: Bool
    @State var name: String = ""
    @State var birthDate: Date = Date.now
    @State var gender: Gender?
    @State var firestoreReference = Firestore.firestore()
    @EnvironmentObject var user: User
    
    
    var body: some View {
        ZStack {
            Color.purple.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Create A LiftWell Account")
                        .foregroundColor(.white)
                        .font(.custom("GillSans-SemiboldItalic", size: 26))
                        .padding()
                    Spacer()
                }
                
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("GillSans-SemiboldItalic", size: 26))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white))
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("GillSans-SemiboldItalic", size: 26))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white))
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("GillSans-SemiboldItalic", size: 26))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white))
                    .padding()
                
                Menu {
                    Button("\(Gender.Male.rawValue)", action: { self.gender = Gender.Male })
                    Button("\(Gender.Female.rawValue)", action: { self.gender  = Gender.Female })
                    Button("\(Gender.Other.rawValue)", action: { self.gender = Gender.Other })
                } label: {
                    HStack {
                        Text("Gender")
                            .font(.custom("GillSans-SemiboldItalic", size: 26))
                            .foregroundColor(.purple)
                        Image(systemName: "hand.tap.fill")
                            .foregroundColor(.purple)
                    }
                    .padding()
                    Spacer()
                    
                }
                .frame(width: 360, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 3)
                        .foregroundColor(.white))
                .background(.white)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 3)
                        .foregroundColor(.white)
                    DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                        Text("Birthdate")
                            .font(.custom("GillSans-SemiboldItalic", size: 26))
                            .foregroundColor(.purple)
                    }
                    .padding()
                    .colorMultiply(Color.white)
                    .background(.white)
                    .accentColor(.purple)
                }
                .frame(width: 360, height: 50)
                .background(.white)
                .padding()
                
                Button {
                    withAnimation {
                        self.currentShowingView = "login"
                    }
                } label: {
                    Text("Already have an account?")
                        .font(.custom("GillSans-SemiboldItalic", size: 18))
                        .tint(.white)
                }
                .padding()
                
                Button {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, err in
                        if let err = err {
                            print(err)
                            return
                        }
                        if let authResult = authResult {
                            withAnimation {
                                userID = authResult.user.uid
                                currentShowingMain = false
                            }
                            // Should also produce action sheet to generate user information
                            let now = Date()
                            let calendar = Calendar.current
                            
                            let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date.now)
                            let age = ageComponents.year!
                            var ref: DocumentReference? = nil
                            user.setUser(other: User(userID: userID, name: name, email: email, gender: Gender(rawValue: gender!.rawValue)!, age: age, workouts: [], friends: []))
                            ref = firestoreReference.collection("users").addDocument(data: [
                                "userID": user.userID,
                                "name": user.name,
                                "email": user.email,
                                "age": user.age,
                                "gender": user.gender.rawValue,
                                "workouts": user.workouts,
                                "friends": user.friends]) { err in
                                    if let err = err {
                                        print("Error adding document: \(err)")
                                    } else {
                                        print("Document added with ID: \(ref!.documentID)")
                                    }
                                    
                                }
                            
                        }
                        
                    }
                } label: {
                    Text("Create New Account")
                        .foregroundColor(.purple)
                        .font(.custom("GillSans-SemiboldItalic", size: 26))
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.white)
            }
        }
        
    }
}
