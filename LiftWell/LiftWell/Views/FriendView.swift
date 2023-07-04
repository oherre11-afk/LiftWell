//
//  FriendView.swift
//  LiftWell
//
//  Created by Evan Slaney on 5/15/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore



struct FriendView: View {
    @State var email: String = ""
    @State var friendsList: [Friend] = []
    @EnvironmentObject var user: User
    @State var db = Firestore.firestore()
    @State var documentId: String = ""
    
    /*let friends = [Friend(userID: "oherre11", name: "Oscar Herrera" , gender: Gender.Male, age: 25),
                   Friend(userID: "Gm12", name: "George Martinez" , gender: Gender.Male, age: 23),
                   Friend(userID: "AlRod", name: "Alex Rodgers" , gender: Gender.Male, age: 19),
                   Friend(userID: "Sar22", name: "Sara Golburg" , gender: Gender.Female, age: 23),
    ] */

    func fetchFriendsList() {
        let collectionRef = db.collection("users")
        let query = collectionRef.whereField("userID", arrayContains: user.userID)
        
        query.getDocuments{(querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            for document in documents {
                let data = document.data()
                print("Hi")
                if let friends = data["friends"] as? [String] {
                    // Access the friends array and perform operations
                    print("Hi")
                    print(friends)
                }
            }
        }
    }
    
    func parseFriendData(_ friendData: [String: Any]) -> Friend? {
        guard let gender = friendData["gender"] as? String,
              let name = friendData["name"] as? String,
              let userID = friendData["userID"] as? String else {
            return nil
        }
        
        let friend = Friend(userID: userID, name: name, gender: Gender(rawValue: gender) ?? Gender.Male, age: 0)
        
        return friend
    }
    
    
    var body: some View {
        
        VStack {
            ScrollView {
                ForEach(0..<friendsList.count, id: \.self ) { i in
                    ProfileView(person: friendsList[i])
                }
            }
            
            Text("Current Friends")
                .foregroundStyle(.purple.gradient)
                .font(.custom("GillSans-SemiboldItalic", size: 40))
            
            
            Spacer()
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .font(.custom("GillSans-SemiboldItalic", size: 32))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.purple))
                .padding()
            
            Button {
                
                fetchFriendsList()
                
                
                let collectionRef = db.collection("users")
                var FriendUserID = ""
                var FriendName = ""
                var FriendGender = ""
                var FriendAge = 0
                
                fetchFriendsList()
                print(friendsList.count)
                
                collectionRef.whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
                    
                    
                    if let error = error {
                        print("Error getting documents")
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        print("No documents found")
                        return
                    }
                    
                    for document in documents {
                        let data = document.data()
                        
                        
                        if let username = data["userID"] as? String {
                            FriendUserID = username
                        }
                        
                        if let name = data["name"] as? String {
                            FriendName = name
                        }
                        
                        
                        
                        if let age = data["age"] as? Int {
                            FriendAge = age
                        }
                        
                        
                        if let gender = data["gender"] as? String{
                            FriendGender = gender
                        }
                        
                        
                         let newFriend = Friend(userID: FriendUserID, name: FriendName, gender: Gender(rawValue: FriendGender) ?? Gender.Male, age: FriendAge)
                    
                        friendsList.append(newFriend)
                        print(friendsList)
                        
                    }
                    
                }
                 
                
            } label: {
                Text("Add a friend")
                    .foregroundColor(.white)
                    .font(.custom("GillSans-SemiboldItalic", size: 26))
            }   .padding()
                .buttonStyle(.borderedProminent)
                .tint(.purple)
            
        }
    }
}
