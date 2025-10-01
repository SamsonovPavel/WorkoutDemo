//
//  OnboardingViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol OnboardingViewModelProtocol {
    func bind(_ input: OnboardingViewModel.Input) -> OnboardingViewModel.Output
}

// MARK: - ViewModel

class OnboardingViewModel: OnboardingViewModelProtocol {
    
    private let completeSubject = PassthroughSubject<Void, Never>()
    private var bindings = Set<AnyCancellable>()
    
    func bind(_ input: Input) -> Output {
        input.run
            .sink(receiveValue: completeSubject.send)
            .store(in: &bindings)
        
        return .init()
    }
}

extension OnboardingViewModel {
    
    struct Input {
        let run: AnyPublisher<Void, Never>
    }
    
    struct Output {}
}

extension OnboardingViewModel: OnboardingModuleOutput {
    var completePublisher: AnyPublisher<Void, Never> {
        completeSubject.eraseToAnyPublisher()
    }
}
