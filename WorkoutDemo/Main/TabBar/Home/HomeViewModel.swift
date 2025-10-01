//
//  HomeViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol HomeViewModelProtocol {
    func bind(_ input: HomeViewModel.Input) -> HomeViewModel.Output
}

// MARK: - ViewModel

class HomeViewModel: HomeViewModelProtocol {
    
    private let addWorkoutSubject = PassthroughSubject<Void, Never>()
    private var bindings = Set<AnyCancellable>()
    
    func bind(_ input: Input) -> Output {
        input.addWorkoutPublisher
            .sink { [unowned self] in
                addWorkoutSubject.send(())
                
            }.store(in: &bindings)
        
        return .init()
    }
}

extension HomeViewModel {
    
    struct Input {
        let addWorkoutPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {}
}

extension HomeViewModel: HomeModuleOutput {
    var addWorkout: AnyPublisher<Void, Never> {
        addWorkoutSubject.eraseToAnyPublisher()
    }
}
