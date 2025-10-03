//
//  DetailViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Foundation
import Combine

protocol DetailViewModelProtocol {
    var currentModel: DetailViewModel.Model { get }
    func bind(_ input: DetailViewModel.Input)
}

class DetailViewModel: DetailViewModelProtocol {
    
    private let startWorkoutSubject = PassthroughSubject<Model, Never>()
    
    private let model: Model
    private var bindings = Set<AnyCancellable>()
    
    var currentModel: Model {
        model
    }
    
    init(model: Model) {
        self.model = model
    }
    
    func bind(_ input: Input) {
        input.startWorkout
            .receive(on: .mainQueue)
            .sink { [unowned self] in
                startWorkoutSubject.send(model)
                
            }.store(in: &bindings)
    }
}

extension DetailViewModel {
    
    struct Model: Hashable {
        
        let title: String
        let date: Date
        let duration: String
    }
    
    struct Input {
        let startWorkout: AnyPublisher<Void, Never>
    }
}

extension DetailViewModel: DetailModuleOutput {
    var startWorkout: AnyPublisher<Model, Never> {
        startWorkoutSubject.eraseToAnyPublisher()
    }
}
