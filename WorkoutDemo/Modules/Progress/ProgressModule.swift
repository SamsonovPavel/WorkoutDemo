//
//  ProgressModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Combine

protocol ProgressModuleOutput {
    var cancelWorkout: AnyPublisher<Void, Never> { get }
}

class ProgressModule: OutputModule<ProgressModuleOutput> {}
