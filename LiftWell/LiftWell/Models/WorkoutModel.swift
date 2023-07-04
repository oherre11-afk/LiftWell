//
//  WorkoutModel.swift
//  LiftWell
//
//  Created by Evan Slaney on 5/15/23.
//

import Foundation

class Workout: Codable {
    
    var exercises: [ExerciseModel] = []
    var date = Date.now
    
    func addExercise(exercise: ExerciseModel) {
        exercises.append(exercise)
    }
    
}

