//
//  DetailModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Combine

protocol DetailModuleOutput {
    var startWorkout: AnyPublisher<DetailViewModel.Model, Never> { get }
}

class DetailModule: OutputModule<DetailModuleOutput> {}
