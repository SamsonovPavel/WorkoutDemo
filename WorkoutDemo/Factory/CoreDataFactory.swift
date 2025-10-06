//
//  CoreDataFactory.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 06.10.2025.
//

struct CoreDataFactory {
    
    private let shared = CoreDataStack.shared
    
    // Добавляем в CoreData тренировку
    func addWorkout(title: String, duration: String) throws {
        CoreDataStack.shared.addNewWorkout(
            title: title,
            duration: duration
        )
    }
 
    // Добавляем при первом старте приложения
    func mockAddWorkout() {
        Task(priority: .medium) {
            let result = try shared.fetchAllWorkouts()
            
            if result.isEmpty {
                try addWorkout(title: "Тренировка дома", duration: "1")
                try addWorkout(title: "Тренировка в зале", duration: "3")
                try addWorkout(title: "Тренировка на работе", duration: "120")
            }
        }
    }
}
