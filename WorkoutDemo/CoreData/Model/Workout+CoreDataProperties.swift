//
//  Workout+CoreDataProperties.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var duration: String?
    @NSManaged public var date: Date?

}

extension Workout: Identifiable {

    func updateWorkout(title: String, duration: String, date: Date) {
        self.title = title
        self.duration = duration
        self.date = date
        
        if let context = managedObjectContext {
            try? context.save()
        }
    }
    
    func deleteWorkout() {
        if let context = managedObjectContext {
            context.delete(self)
            try? context.save()
        }
    }
}
