//
//  ListWorkoutViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol ListWorkoutViewModelProtocol {
    func bind(_ input: ListWorkoutViewModel.Input) -> ListWorkoutViewModel.Output
}

// MARK: - ViewModel

class ListWorkoutViewModel: ListWorkoutViewModelProtocol {
    
    typealias RowType = ListCollectionDataSource.RowType
    
    private let addWorkoutSubject = PassthroughSubject<Void, Never>()
    private let didSelectRowSubject = PassthroughSubject<RowType, Never>()
    private let resetBadgeSubject = PassthroughSubject<Void, Never>()
    
    private var bindings = Set<AnyCancellable>()
    
    func bind(_ input: Input) -> Output {
        input.didSelectRow
            .receive(on: .mainQueue)
            .sink(receiveValue: didSelectRowSubject.send)
            .store(in: &bindings)
        
        input.resetBadge
            .receive(on: .mainQueue)
            .sink(receiveValue: resetBadgeSubject.send)
            .store(in: &bindings)
        
        return .init(addWorkoutPublisher: addWorkoutSubject
            .eraseToAnyPublisher()
        )
    }
}

extension ListWorkoutViewModel {
    
    struct Input {
        let didSelectRow:AnyPublisher<RowType, Never>
        let resetBadge: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let addWorkoutPublisher: AnyPublisher<Void, Never>
    }
}

extension ListWorkoutViewModel: ListWorkoutModuleInput {
    func updateList() {
        addWorkoutSubject.send()
    }
}

extension ListWorkoutViewModel: ListWorkoutModuleOutput {
    
    var didSelectRow: AnyPublisher<RowType, Never> {
        didSelectRowSubject.eraseToAnyPublisher()
    }
    
    var resetBadge: AnyPublisher<Void, Never> {
        resetBadgeSubject.eraseToAnyPublisher()
    }
}
