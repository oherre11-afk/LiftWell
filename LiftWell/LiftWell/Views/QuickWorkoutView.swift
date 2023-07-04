//
//  QuickWorkoutView.swift
//  LiftWell
//
//  Created by Evan Slaney on 5/15/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct QuickWorkoutView: View {
    
    @State var workout: Workout? = nil
    @State var upperBodyView: Bool = false
    @State var lowerBodyView: Bool = false
    @State var fullBodyView: Bool = false
    @State var conditioningView: Bool = false
    @EnvironmentObject var user: User
    var firestoreReference = Firestore.firestore()
    
    func addWorkout(workout: Workout) {
        //The function will add a workout to the database based on the current user, and will also update the current internal user state
        firestoreReference.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let curr = document.data()
                    if curr["userID"] as! String == user.userID {
                        //Update database
                        if let test = try?
                            firestoreReference.collection("users").document(document.documentID).setData(from: self.user) {
                            print("successfully updated user data in Firebase")
                        }
                        
                    }
                }
            }
        }
    }
    
    func imageString(exercise: ExerciseModel) -> String? {
        if exercise.name == "Romanian Deadlift" {
            return "rdl"
        } else if exercise.name == "Squats" {
            return "squat"
        }  else if exercise.name == "Hammer Curls" {
            return "hC"
        } else if exercise.name == "Bicep Curls" {
            return "bicepCurls"
        } else if exercise.name == "Dumbbell Bench Press" {
            return "dbBenchPress"
        } else if exercise.name == "Chest Press" {
            return "chestPress"
        } else if exercise.name == "Tricep Pushdowns" {
            return "triPD"
        } else if exercise.name == "Tricep Dips" {
            return "tricepDips"
        } else if exercise.name == "Pulley Row" {
            return "pulleyRow"
        }  else if exercise.name == "Pull Ups" {
            return "pullUps"
        } else if exercise.name == "Rear Delt Fly" {
            return "rdf"
        } else if exercise.name == "Lateral Raise" {
            return "latRaise"
        }
        return ""
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select A Workout")
                Spacer()
                VStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 3)
                            .foregroundStyle(.purple.gradient)
                        Button {
                            workout = Workout()
                            workout?.addExercise(exercise: ExerciseModel(name: "Dumbbell Bench Press", bodyPart: "Chest", reps: "3 x 12-15", duration: 15, caloriesBurned: 100, description: "The dumbbell bench press is a variation of the barbell bench press and an exercise used to build the muscles of the chest. Often times, the dumbbell bench press is recommended after reaching a certain point of strength on the barbell bench press to avoid pec and shoulder injuries."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Tricep Pushdowns", bodyPart: "Triceps", reps: "3 x 12-15", duration: 15, caloriesBurned: 130, description: "The tricep pushdown is one of the best exercises for tricep development. While the versatile upper-body workout is usually done on a cable machine (a fixture at most gyms), you can also perform a version of the move at home or on the go using a resistance band."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Lateral Raise", bodyPart: "Shoulders", reps: "4 x 12-15", duration: 10, caloriesBurned: 175, description: "A lateral raise is a strength training shoulder exercise characterized by lifting a pair of dumbbells away from your body in an external rotation. Lateral raises work the trapezius muscle in your upper back as well as the deltoid muscle group in your shoulders—particularly the anterior and lateral deltoids."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Bicep Curls", bodyPart: "Biceps", reps: "3 x 10-12", duration: 20, caloriesBurned: 150, description: "The biceps curl is a highly recognizable weight-training exercise that works the muscles of the upper arm and, to a lesser extent, those of the lower arm."))
                            upperBodyView = true
                        } label: {
                            HStack {
                                Text("Upper Body Workout")
                                Spacer()
                                Image(systemName: "hand.point.right.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        .foregroundColor(.white)
                        .navigationDestination(isPresented: $upperBodyView) {
                            ScrollView {
                                HStack {
                                    Button {
                                        upperBodyView = false
                                    } label: {
                                        Text("Cancel")
                                            .foregroundColor(.white)
                                            .font(.custom("GillSans-Semibold", size: 24))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.pink)
                                    .padding()
                                    Spacer()
                                    Button {
                                        user.workouts.append(workout!)
                                        addWorkout(workout: workout!)
                                        upperBodyView = false
                                    } label: {
                                        Text("Start Workout")
                                            .foregroundColor(.white)
                                            .font(.custom("GillSans-Semibold", size: 24))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.purple)
                                    .padding()
                                }
                                LazyVStack(spacing: 20) {
                                    if let workout = workout {
                                        ForEach(workout.exercises) { exercise in
                                            ExerciseCardView(exercise: exercise, image: imageString(exercise: exercise))
                                        }
                                    }
                                    
                                }
                                .padding()
                            }
                            .navigationBarBackButtonHidden(true)
                        }
                        .padding()
                    }
                    
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 3)
                            .foregroundStyle(.purple.gradient)
                        Button {
                            workout = Workout()
                            workout?.addExercise(exercise: ExerciseModel(name: "Squats", bodyPart: "Legs", reps: "3 x 8-10", duration: 30, caloriesBurned: 100, description: "The basic squat is an extremely effective lower body move that strengthens all leg muscles including glutes, quads, hamstrings and calves."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Romanian Deadlift", bodyPart: "Legs", reps: "3 x 10-12", duration: 20, caloriesBurned: 120, description: "The Romanian deadlift (RDL) is a traditional barbell lift used to develop the strength of the posterior chain muscles, including the erector spinae, gluteus maximus, hamstrings and adductors. When done correctly, the RDL is an effective exercise that helps strengthen both the core and the lower body with one move."))
                            lowerBodyView = true
                        } label: {
                            HStack {
                                Text("Lower Body Workout")
                                Spacer()
                                Image(systemName: "hand.point.right.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        .foregroundColor(.white)
                        .navigationDestination(isPresented: $lowerBodyView) {
                            ScrollView {
                                HStack {
                                    Button {
                                        lowerBodyView = false
                                    } label: {
                                        Text("Cancel")
                                            .foregroundColor(.white)
                                            .font(.custom("GillSans-Semibold", size: 24))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.pink)
                                    .padding()
                                    Spacer()
                                    Button {
                                        user.workouts.append(workout!)
                                        addWorkout(workout: workout!)
                                        lowerBodyView = false
                                    } label: {
                                        Text("Start Workout")
                                            .foregroundColor(.white)
                                            .font(.custom("GillSans-Semibold", size: 24))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.purple)
                                    .padding()
                                }
                                LazyVStack(spacing: 20) {
                                    if let workout = workout {
                                        ForEach(workout.exercises) { exercise in
                                            ExerciseCardView(exercise: exercise, image: imageString(exercise: exercise))
                                        }
                                    }
                                    
                                }
                                .padding()
                            }
                            .navigationBarBackButtonHidden(true)
                        }
                        .padding()
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 3)
                            .foregroundStyle(.purple.gradient)
                        Button {
                            workout = Workout()
                            workout?.addExercise(exercise: ExerciseModel(name: "Hammer Curls", bodyPart: "Biceps", reps: "3 x 10-12", duration: 20, caloriesBurned: 140, description: "Hammer curls are biceps curls performed with your hands facing each other. They're beneficial to add mass to your arms and can help focus more attention on the short head of the biceps. They may be easier to tolerate than the traditional biceps curl."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Chest Press", bodyPart: "Chest", reps: "3 x 10-12", duration: 25, caloriesBurned: 200, description: "The chest press strength training exercise works the pectoral muscles of the chest. You can use a variety of equipment, including dumbbells, barbells, a Smith machine, suspension trainer, or even resistance bands, to perform a chest press."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Tricep Dips", bodyPart: "Triceps", reps: "4 x 12-15", duration: 20, caloriesBurned: 125, description: "The triceps dip exercise is a great bodyweight exercise that builds arm and shoulder strength. This simple exercise can be done almost anywhere and has many variations to match your fitness level. Use it as part of an upper-body strength workout."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Pulley Row", bodyPart: "Back", reps: "3 x 8-10", duration: 15, caloriesBurned: 140, description: "The seated cable row develops the muscles of the back and the forearms. It is an excellent all-around compound exercise for developing the middle back while offering useful arm work as well.The seated cable row is performed on a weighted horizontal cable machine with a bench and footplates."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Rear Delt Fly", bodyPart: "Shoulders", reps: "3 x 8-10", duration: 10, caloriesBurned: 160, description: "A rear delt fly is an effective exercise that targets your deltoid muscles. Although it does work numerous muscles in the upper body, it mainly focuses on the shoulder muscles. The incorporation of upper body muscles not only improves performance in the gym but can also improve your quality of life by making functional, daily movements easier."))
                            fullBodyView = true
                        } label: {
                            HStack {
                                Text("Full Body Workout")
                                Spacer()
                                Image(systemName: "hand.point.right.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        .foregroundColor(.white)
                        .navigationDestination(isPresented: $fullBodyView) {
                            ScrollView {
                                HStack {
                                    Button {
                                        fullBodyView = false
                                    } label: {
                                        Text("Cancel")
                                            .foregroundColor(.white)
                                            .font(.custom("GillSans-Semibold", size: 24))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.pink)
                                    .padding()
                                    Spacer()
                                    Button {
                                        user.workouts.append(workout!)
                                        addWorkout(workout: workout!)
                                        fullBodyView = false
                                    } label: {
                                        Text("Start Workout")
                                            .foregroundColor(.white)
                                            .font(.custom("GillSans-Semibold", size: 24))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.purple)
                                    .padding()
                                }
                                LazyVStack(spacing: 20) {
                                    if let workout = workout {
                                        ForEach(workout.exercises) { exercise in
                                            ExerciseCardView(exercise: exercise, image: imageString(exercise: exercise))
                                        }
                                    }
                                    
                                }
                                .padding()
                            }
                            .navigationBarBackButtonHidden(true)
                        }
                        .padding()
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 3)
                            .foregroundStyle(.purple.gradient)
                        Button {
                            workout = Workout()
                            // Add conditioning here
                            workout?.addExercise(exercise: ExerciseModel(name: "Run", bodyPart: "Lungs", reps: "", duration: 15, caloriesBurned: 160, description: "Swing right knee forward while left leg extends back and remains in contact with ground. In unison to leg movement, swing left bent arm forward and right bent arm back. Extend right leg forward as left heal rises off ground. Extend left foot as left hip and knee terminate extension propelling body forward as both feet are no longer in contact with ground. Begin to swing left arm back and right arm forward. Continue to extend right knee in preparation for initial landing while raising left heel toward buttock. As right foot makes contact with ground continue to pull left heel toward buttock. Allow right knee to bend as it quickly travels underneath body. As left knee begins to be pulled forward, left arm continues to travel back behind body while right arm continues to swing forward. Repeat running pattern with movements on opposite sides, alternating between sides. Continue running until specific distance is covered or prescribed time has elapsed."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Burpee", bodyPart: "Lungs", reps: "", duration: 3, caloriesBurned: 160, description: "Bend over and squat down. Place hands on floor, slightly wider than shoulder width. While holding upper body in place, buck hips ups slightly by extending knees and hips, then immediately kick legs back. Land on forefeet with body in straight, plank position. Keeping upper body in place buck hip up and rapidly pull legs forward under body returning feet in original position. Rise up to original standing posture."))
                            workout?.addExercise(exercise: ExerciseModel(name: "Cycling", bodyPart: "Lungs", reps: "", duration: 15, caloriesBurned: 160, description: "Sit on upright cycle seat with feet on pedals and grasp handlebars. Select \"quick start\" or enter program."))
                            conditioningView = true
                        } label: {
                            HStack {
                                Text("Conditioning")
                                Spacer()
                                Image(systemName: "hand.point.right.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        .foregroundColor(.white)
                        .navigationDestination(isPresented: $conditioningView) {
                            ScrollView {
                                HStack {
                                    Button {
                                        conditioningView = false
                                    } label: {
                                        Text("Cancel")
                                            .foregroundColor(.white)
                                            .font(.custom("GillSans-Semibold", size: 24))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.pink)
                                    .padding()
                                    Spacer()
                                    Button {
                                        user.workouts.append(workout!)
                                        addWorkout(workout: workout!)
                                        conditioningView = false
                                    } label: {
                                        Text("Start Workout")
                                            .foregroundColor(.white)
                                            .font(.custom("GillSans-Semibold", size: 24))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.purple)
                                    .padding()
                                }
                                LazyVStack(spacing: 20) {
                                    if let workout = workout {
                                        ForEach(workout.exercises) { exercise in
                                            ExerciseCardView(exercise: exercise, image: imageString(exercise: exercise))
                                        }
                                    }
                                    
                                }
                                .padding()
                            }
                            .navigationBarBackButtonHidden(true)
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
            .font(.custom("GillSans-Semibold", size: 28))
            .padding()
        }
        
    }
}

struct QuickWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        QuickWorkoutView()
    }
}
