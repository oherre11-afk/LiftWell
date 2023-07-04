//
//  ProfileView.swift
//  LiftWell
//
//  Created by Oscar Herrera on 5/16/23.
//

import SwiftUI

struct ProfileView: View {
    @State var person: Friend
    
    var body: some View {
        
        
        VStack {
            Image(systemName: "person.fill")
            Text(person.name)
            Text("Gender: " + person.gender.rawValue)
            Text("Age: " + String(person.age))
        }
        
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
        .font(.custom("GillSans-SemiboldItalic", size: 20))
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let friend = Friend(userID: "oherre11", name: "Oscar", gender: Gender.Male, age: 25)

        ProfileView(person: friend)
    }

}
