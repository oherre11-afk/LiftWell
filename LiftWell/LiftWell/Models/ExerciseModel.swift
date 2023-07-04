//
//  ExerciseModel.swift
//  LiftWell
//
//  Created by ok on 5/8/23.
//
import Foundation
struct ExerciseModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var bodyPart: String
    var reps: String
    var duration: Int
    var caloriesBurned: Int
    var description: String
    var videoURL: URL?
}
