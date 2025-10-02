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
    
    private let addWorkoutSubject = PassthroughSubject<Int, Never>()
    private var bindings = Set<AnyCancellable>()
    
    func bind(_ input: Input) -> Output {
        input.addWorkoutPublisher
            .receive(on: .mainQueue)
            .sink { [unowned self] model in
                Task(priority: .medium) {
                    do {
                        let result = try addWorkout(
                            title: model.title,
                            duration: model.duration
                        )
                        
                        addWorkoutSubject.send(result.count)
                        
                    } catch {
                 
                        throw CoreDataStack.CoreDataError.unknown(
                            error
                        )
                    }
                }
                
            }.store(in: &bindings)
        
        return .init()
    }
    
    // Добавляем в CoreData тренировку и отправляем для badge количество всех тренировок
    private func addWorkout(title: String, duration: String) throws -> [Workout] {
        let shared = CoreDataStack.shared
        
        shared.addNewWorkout(
            title: title,
            duration: duration
        )
        
        return try shared.fetchAllWorkouts()
    }
}

extension HomeViewModel {
    
    struct Input {
        let addWorkoutPublisher: AnyPublisher<NewWorkoutView.Model, Never>
    }
    
    struct Output {}
}

extension HomeViewModel: HomeModuleOutput {
    var addWorkout: AnyPublisher<Int, Never> {
        addWorkoutSubject.eraseToAnyPublisher()
    }
}
