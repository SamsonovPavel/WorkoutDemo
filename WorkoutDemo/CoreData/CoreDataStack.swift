//
//  CoreDataStack.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WorkoutDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    enum CoreDataError: Error {
        
        case invalidRequest
        case unknown(Error)
        
        var description: String {
            switch self {
            case .invalidRequest: return "Invalid request"
            case .unknown(let error): return "Unknown error: \(error.localizedDescription)"
            }
        }
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataStack {
    
    func fetchAllWorkouts() throws -> [Workout] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<Workout> = Workout.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            throw CoreDataError.invalidRequest
        }
    }
    
    func addNewWorkout(title: String, duration: String) {
        guard title.isEmpty == false, duration.isEmpty == false else {
            return
        }
        
        let context = persistentContainer.viewContext
        let newWorkout = Workout(context: context)
        
        newWorkout.id = UUID().uuidString
        newWorkout.title = title
        newWorkout.duration = duration
        newWorkout.date = Date()
        
        saveContext( )
    }
}
