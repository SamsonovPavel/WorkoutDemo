//
//  SplashModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol SplashModuleOutput {
    var completePublisher: AnyPublisher<Void, Never> { get }
}

class SplashModule: OutputModule<SplashModuleOutput> {}
