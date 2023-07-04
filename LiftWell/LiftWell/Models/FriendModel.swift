//
//  FriendModel.swift
//  LiftWell
//
//  Created by Oscar Herrera on 5/16/23.
//

import Foundation


class Friend: Encodable, Decodable {
    @Published var userID: String
    @Published var name: String
    @Published var gender: Gender
    @Published var age: Int
    
    init(userID: String, name: String, gender: Gender, age: Int) {
        self.userID = userID
        self.name = name
        self.gender = gender
        self.age = age
    }
    
    enum CodingKeys: String, CodingKey {
           case userID
           case name
           case gender
           case age
       }
       
       required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.userID = try container.decode(String.self, forKey: .userID)
           self.name = try container.decode(String.self, forKey: .name)
           self.gender = try container.decode(Gender.self, forKey: .gender)
           self.age = try container.decode(Int.self, forKey: .age)
       }
    
     func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(userID, forKey: .userID)
           try container.encode(name, forKey: .name)
           try container.encode(gender, forKey: .gender)
           try container.encode(age, forKey: .age)
       }
    
}

