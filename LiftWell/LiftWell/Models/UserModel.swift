//
//  UserModel.swift
//  LiftWell
//
//  Created by Evan Slaney on 5/9/23.
//

import Foundation

enum Gender: String, Codable, CaseIterable, Identifiable {
    var id : String { UUID().uuidString }
    case Male = "Male"
    case Female = "Female"
    case Other = "Other"
}

/*
 The user struct stores all information about a given user (pulled from existing firebase database). Information includes
 an identificaiton string, user email, gender, age, and previous workouts
*/
class User: ObservableObject, Equatable, Codable {
    static func == (lhs: User, rhs: User) -> Bool {
        if lhs.userID == rhs.userID {
            return true
        }
        return false
    }
    
    @Published var userID: String
    @Published var name: String
    @Published var email: String
    @Published var gender: Gender
    @Published var age: Int
    @Published var workouts: [Workout]
    @Published var friends: [Friend]
    
    init(userID: String, name: String, email: String, gender: Gender, age: Int, workouts: [Workout], friends: [Friend]) {
        self.userID = userID
        self.name = name
        self.email = email
        self.gender = gender
        self.age = age
        self.workouts = workouts
        self.friends = friends
    }
    
    func setUser(other: User) {
        self.userID = other.userID
        self.name = other.name
        self.email = other.email
        self.gender = other.gender
        self.age = other.age
        self.workouts = other.workouts
        self.friends = other.friends
    }
    
    enum CodingKeys: CodingKey {
        case userID, name, email, gender, age, workouts, friends
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userID, forKey: .userID)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(gender, forKey: .gender)
        try container.encode(age, forKey: .age)
        try container.encode(workouts, forKey: .workouts)
        try container.encode(friends, forKey: .friends)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userID = try container.decode(String.self, forKey: .userID)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        gender = try container.decode(Gender.self, forKey: .gender)
        age = try container.decode(Int.self, forKey: .age)
        workouts = try container.decode([Workout].self, forKey: .workouts)
        friends = try container.decode([Friend].self, forKey: .friends)
    }
    
}
