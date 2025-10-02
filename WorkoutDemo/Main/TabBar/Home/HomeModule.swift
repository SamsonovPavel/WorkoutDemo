//
//  HomeModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol HomeModuleOutput {
    var addWorkout: AnyPublisher<Int, Never> { get }
}

class HomeModule: OutputModule<HomeModuleOutput> {}
