//
//  ProgressViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Foundation
import Combine

protocol ProgressViewModelProtocol {
    var currentModel: ProgressViewModel.Model { get }
    func bind(_ input: ProgressViewModel.Input)
}

class ProgressViewModel: ProgressViewModelProtocol {
    
    private let cancelWorkoutSubject = PassthroughSubject<Void, Never>()
    
    private let model: Model
    private var bindings = Set<AnyCancellable>()
    
    var currentModel: Model {
        model
    }
    
    init(model: Model) {
        self.model = model
    }
    
    func bind(_ input: Input) {
        input.cancelWorkout
            .receive(on: .mainQueue)
            .sink { [unowned self] in
                cancelWorkoutSubject.send()
                
                // Обновление состояния тренировки в CoreDate
                
            }.store(in: &bindings)
    }
}

extension ProgressViewModel {
    
    struct Model: Hashable {
        
        let title: String
        let date: Date
        let duration: String
    }
    
    struct Input {
        let cancelWorkout: AnyPublisher<Void, Never>
    }
}

extension ProgressViewModel: ProgressModuleOutput {
    var cancelWorkout: AnyPublisher<Void, Never> {
        cancelWorkoutSubject.eraseToAnyPublisher()
    }
}
