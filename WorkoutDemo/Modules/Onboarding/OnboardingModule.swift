//
//  OnboardingModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol OnboardingModuleOutput {
    var completePublisher: AnyPublisher<Void, Never> { get }
}

class OnboardingModule: OutputModule<OnboardingModuleOutput> {}
