//
//  SplashViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol SplashViewModelProtocol {
    func bind(_ input: SplashViewModel.Input) -> SplashViewModel.Output
}

// MARK: - ViewModel

class SplashViewModel: SplashViewModelProtocol {
    
    private let completeSubject = PassthroughSubject<Void, Never>()
    private var bindings = Set<AnyCancellable>()
    
    func bind(_ input: Input) -> Output {
        input.run
            .sink(receiveValue: completeSubject.send)
            .store(in: &bindings)
        
        return .init()
    }
}

extension SplashViewModel {
    
    struct Input {
        let run: AnyPublisher<Void, Never>
    }
    
    struct Output {}
}

extension SplashViewModel: SplashModuleOutput {
    var completePublisher: AnyPublisher<Void, Never> {
        completeSubject.eraseToAnyPublisher()
    }
}
