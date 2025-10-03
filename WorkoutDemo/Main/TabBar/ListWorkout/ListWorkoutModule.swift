//
//  ListWorkoutModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol ListWorkoutModuleOutput {
    var didSelectRow: AnyPublisher<ListCollectionDataSource.RowType, Never> { get }
}

protocol ListWorkoutModuleInput {
    func updateList()
}

class ListWorkoutModule: BaseModule<ListWorkoutModuleInput, ListWorkoutModuleOutput> {}
