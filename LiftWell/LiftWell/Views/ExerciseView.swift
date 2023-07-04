//
//  ExerciseView.swift
//  LiftWell
//
//  Created by ok on 5/8/23.
//

import SwiftUI

enum Exercises: String, CaseIterable, Identifiable {
    case legs, biceps, chest, triceps, back, shoulders
    var id: Self { self }
}

struct ExerciseCardView: View {
    let exercise: ExerciseModel
    let image: String?
    var body: some View {
        VStack {
            NavigationLink(destination: ExerciseDetailsView(exercise: exercise)) {
                VStack(alignment: .leading, spacing: 8) {
                    if let imageName = image {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .cornerRadius(10)
                    }
                    
                    Text(exercise.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text("Reps: \(exercise.reps)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Duration: \(exercise.duration) minutes")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(12)
            }
            .foregroundColor(.black)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 10)
    }
}

struct ExerciseDetailsView: View {
    let exercise: ExerciseModel
    
    var body: some View {
        VStack {
            Text(exercise.name)
                .font(.title)
                .fontWeight(.bold)
            if let videoURL = exercise.videoURL {
                Button(action: {
                    openVideoInBrowser(videoURL: videoURL)
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(width: 400, height: 250)
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                }
            }

            HStack {
                Text(exercise.description)
                    .font(.system(size: 18))
                    .foregroundColor(Color.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.purple.gradient)
                    )
            }
            Spacer()
        }
        
    }
    
    private func openVideoInBrowser(videoURL: URL) {
        UIApplication.shared.open(videoURL)
    }
}

struct ExerciseView: View {
    @State private var selectedCategory: Exercises = .legs
    let workouts: [Exercises: [ExerciseModel]] = [
        .legs: [
            ExerciseModel(name: "Squats", bodyPart: "Legs", reps: "3 x 8-10", duration: 30, caloriesBurned: 100, description: "The basic squat is an extremely effective lower body move that strengthens all leg muscles including glutes, quads, hamstrings and calves.", videoURL: URL(string: "https://www.youtube.com/shorts/AIZ8q1qruKw")),
            ExerciseModel(name: "Romanian Deadlift", bodyPart: "Legs", reps: "3 x 10-12", duration: 20, caloriesBurned: 120, description: "The Romanian deadlift (RDL) is a traditional barbell lift used to develop the strength of the posterior chain muscles, including the erector spinae, gluteus maximus, hamstrings and adductors. When done correctly, the RDL is an effective exercise that helps strengthen both the core and the lower body with one move.", videoURL: URL(string: "https://www.youtube.com/shorts/eHLuROg0FSI"))
        ],
        .biceps: [
            ExerciseModel(name: "Bicep Curls", bodyPart: "Biceps", reps: "3 x 10-12", duration: 20, caloriesBurned: 150, description: "The biceps curl is a highly recognizable weight-training exercise that works the muscles of the upper arm and, to a lesser extent, those of the lower arm.", videoURL: URL(string: "https://www.youtube.com/watch?v=ykJmrZ5v0Oo&pp=ygULYmljZXAgY3VybHM%3D")),
            ExerciseModel(name: "Hammer Curls", bodyPart: "Biceps", reps: "3 x 10-12", duration: 20, caloriesBurned: 140, description: "Hammer curls are biceps curls performed with your hands facing each other. They're beneficial to add mass to your arms and can help focus more attention on the short head of the biceps. They may be easier to tolerate than the traditional biceps curl.", videoURL: URL(string: "https://www.youtube.com/watch?v=TwD-YGVP4Bk&pp=ygUMaGFtbWVyIGN1cmxz"))
        ],
        .chest: [
            ExerciseModel(name: "Chest Press", bodyPart: "Chest", reps: "3 x 10-12", duration: 25, caloriesBurned: 200, description: "The chest press strength training exercise works the pectoral muscles of the chest. You can use a variety of equipment, including dumbbells, barbells, a Smith machine, suspension trainer, or even resistance bands, to perform a chest press.", videoURL: URL(string: "https://www.youtube.com/shorts/4SscB4eAxt4")),
            ExerciseModel(name: "Dumbbell Bench Press", bodyPart: "Chest", reps: "3 x 12-15", duration: 15, caloriesBurned: 100, description: "The dumbbell bench press is a variation of the barbell bench press and an exercise used to build the muscles of the chest. Often times, the dumbbell bench press is recommended after reaching a certain point of strength on the barbell bench press to avoid pec and shoulder injuries.", videoURL: URL(string: "https://www.youtube.com/watch?v=VmB1G1K7v94&pp=ygULY2hlc3QgcHJlc3M%3D"))
        ],
        .triceps: [
            ExerciseModel(name: "Tricep Dips", bodyPart: "Triceps", reps: "4 x 12-15", duration: 20, caloriesBurned: 125, description: "The triceps dip exercise is a great bodyweight exercise that builds arm and shoulder strength. This simple exercise can be done almost anywhere and has many variations to match your fitness level. Use it as part of an upper-body strength workout.", videoURL: URL(string: "https://www.youtube.com/watch?v=6kALZikXxLc&pp=ygUKdHJpY2VwIGRpcA%3D%3D")),
            ExerciseModel(name: "Tricep Pushdowns", bodyPart: "Triceps", reps: "3 x 12-15", duration: 15, caloriesBurned: 130, description: "The tricep pushdown is one of the best exercises for tricep development. While the versatile upper-body workout is usually done on a cable machine (a fixture at most gyms), you can also perform a version of the move at home or on the go using a resistance band.", videoURL: URL(string: "https://www.youtube.com/watch?v=2-LAMcpzODU&pp=ygUQdHJpY2VwIHB1c2hkb3ducw%3D%3D"))
        ],
        .back: [
            ExerciseModel(name: "Pull Up", bodyPart: "Back", reps: "3 x 4-8", duration: 15, caloriesBurned: 150, description: "The pullup exercise is one of the most overlooked exercises for building upper body, back, and core strength. It requires a chin-up bar, which can be freestanding or you can purchase a simple doorway bar. The traditional pullup uses an overhand grip on the bar, while the chin-up is a variation that generally uses an underhand grip. If you are new to pullups, there are many modified versions that can be used to build the strength needed to perform them. Pullups can be part of an upper body strength workout or a circuit training workout.", videoURL: URL(string: "https://www.youtube.com/watch?v=eGo4IYlbE5g&pp=ygUIcHVsbCB1cHM%3D")),
            ExerciseModel(name: "Pulley Row", bodyPart: "Back", reps: "3 x 8-10", duration: 15, caloriesBurned: 140, description: "The seated cable row develops the muscles of the back and the forearms. It is an excellent all-around compound exercise for developing the middle back while offering useful arm work as well.The seated cable row is performed on a weighted horizontal cable machine with a bench and footplates.", videoURL: URL(string: "https://www.youtube.com/watch?v=GZbfZ033f74&pp=ygUKcHVsbGV5IHJvdw%3D%3D"))
        ],
        .shoulders: [
            ExerciseModel(name: "Lateral Raise", bodyPart: "Shoulders", reps: "4 x 12-15", duration: 10, caloriesBurned: 175, description: "A lateral raise is a strength training shoulder exercise characterized by lifting a pair of dumbbells away from your body in an external rotation. Lateral raises work the trapezius muscle in your upper back as well as the deltoid muscle group in your shoulders—particularly the anterior and lateral deltoids.", videoURL: URL(string: "https://www.youtube.com/watch?v=3VcKaXpzqRo&pp=ygUNbGF0ZXJhbCByYWlzZQ%3D%3D")),
            ExerciseModel(name: "Rear Delt Fly", bodyPart: "Shoulders", reps: "3 x 8-10", duration: 10, caloriesBurned: 160, description: "A rear delt fly is an effective exercise that targets your deltoid muscles. Although it does work numerous muscles in the upper body, it mainly focuses on the shoulder muscles. The incorporation of upper body muscles not only improves performance in the gym but can also improve your quality of life by making functional, daily movements easier.", videoURL: URL(string: "https://www.youtube.com/watch?v=EA7u4Q_8HQ0&pp=ygUNcmVhciBkZWx0IGZseQ%3D%3D"))
        ]
    ]
    
    var filteredExercises: [ExerciseModel] {
        workouts[selectedCategory] ?? []
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Exercise Category", selection: $selectedCategory) {
                    ForEach(Exercises.allCases, id: \.self) { category in
                        Text(category.rawValue.capitalized)
                            .tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(filteredExercises) { exercise in
                            ExerciseCardView(exercise: exercise, image: imageString(for: selectedCategory, exercise: exercise))
                        }
                    }
                    .padding()
                }
            }
            .background(Color.gray.opacity(0.1))
            .navigationTitle("Exercises")
        }
    }
    
    func imageString(for category: Exercises, exercise: ExerciseModel) -> String? {
        switch category {
        case .legs:
            return exercise.name == "Romanian Deadlift" ? "rdl" : "squat"
        case .biceps:
            return exercise.name == "Hammer Curls" ? "hC" : "bicepCurls"
        case .chest:
            return exercise.name == "Dumbbell Bench Press" ? "dbBenchPress" : "chestPress"
        case .triceps:
            return exercise.name == "Tricep Pushdowns" ? "triPD" : "tricepDips"
        case .back:
            return exercise.name == "Pulley Row" ? "pulleyRow" : "pullUps"
        case .shoulders:
            return exercise.name == "Rear Delt Fly" ? "rdf" : "latRaise"
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
