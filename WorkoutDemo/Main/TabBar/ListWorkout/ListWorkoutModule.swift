//
//  ListWorkoutModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol ListWorkoutModuleInput {
    func updateList()
}

class ListWorkoutModule: InputModule<ListWorkoutModuleInput> {}
