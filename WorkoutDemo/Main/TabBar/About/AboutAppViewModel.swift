//
//  AboutAppViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol AboutAppViewModelProtocol {
    func bind(_ input: AboutAppViewModel.Input)
}

// MARK: - ViewModel

class AboutAppViewModel: AboutAppViewModelProtocol {
    
    private let didSelectRowSubject = PassthroughSubject<Void, Never>()
    private let didExitRowSubject = PassthroughSubject<Void, Never>()
    
    private var bindings = Set<AnyCancellable>()
    
    func bind(_ input: Input) {
        input.didSelectRow
            .receive(on: .mainQueue)
            .sink(receiveValue: didSelectRowSubject.send)
            .store(in: &bindings)
        
        input.didExit
            .receive(on: .mainQueue)
            .sink(receiveValue: didExitRowSubject.send)
            .store(in: &bindings)
    }
}

extension AboutAppViewModel {
    
    struct Input {
        let didSelectRow: AnyPublisher<Void, Never>
        let didExit: AnyPublisher<Void, Never>
    }
    
    struct Output {}
}

extension AboutAppViewModel: AboutAppModuleOutput {
    
    var didSelectRow: AnyPublisher<Void, Never> {
        didSelectRowSubject.eraseToAnyPublisher()
    }
    
    var didExit: AnyPublisher<Void, Never> {
        didExitRowSubject.eraseToAnyPublisher()
    }
}
