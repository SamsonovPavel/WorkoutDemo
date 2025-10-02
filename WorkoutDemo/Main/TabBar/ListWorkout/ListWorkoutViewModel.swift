//
//  ListWorkoutViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol ListWorkoutViewModelProtocol {
    func bind() -> ListWorkoutViewModel.Output
}

// MARK: - ViewModel

class ListWorkoutViewModel: ListWorkoutViewModelProtocol {
    
    private let addWorkoutSubject = PassthroughSubject<Void, Never>()
    private var bindings = Set<AnyCancellable>()
    
    func bind() -> Output {
        .init(addWorkoutPublisher: addWorkoutSubject
            .eraseToAnyPublisher()
        )
    }
}

extension ListWorkoutViewModel {
    
    struct Input {}
    
    struct Output {
        let addWorkoutPublisher: AnyPublisher<Void, Never>
    }
}

extension ListWorkoutViewModel: ListWorkoutModuleInput {
    func updateList() {
        addWorkoutSubject.send()
    }
}
