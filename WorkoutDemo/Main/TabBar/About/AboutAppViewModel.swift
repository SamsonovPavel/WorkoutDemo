//
//  AboutAppViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine
import Foundation

protocol AboutAppViewModelProtocol {
    func bind(_ input: AboutAppViewModel.Input)
}

// MARK: - ViewModel

class AboutAppViewModel: AboutAppViewModelProtocol {
    
    // Для строк коллекции
    private let didSelectRowSubject = PassthroughSubject<Void, Never>()
    private let logoutSubject = PassthroughSubject<Void, Never>()
    
    private var bindings = Set<AnyCancellable>()
    
    func bind(_ input: Input) {
        input.didSelectRow
            .receive(on: .mainQueue)
            .sink(receiveValue: didSelectRowSubject.send)
            .store(in: &bindings)
        
        input.logout
            .sink(receiveValue: logout)
            .store(in: &bindings)
    }
    
    private func logout() {
        CoreDataStack.shared.deleteAllWorkouts()
        UserDefaults.loginName = ""

        logoutSubject.send()
    }
}

extension AboutAppViewModel {
    
    struct Input {
        let didSelectRow: AnyPublisher<Void, Never>
        let logout: AnyPublisher<Void, Never>
    }
    
    struct Output {}
}

extension AboutAppViewModel: AboutAppModuleOutput {
    
    var didSelectRow: AnyPublisher<Void, Never> {
        didSelectRowSubject.eraseToAnyPublisher()
    }
    
    var logoutPublisher: AnyPublisher<Void, Never> {
        logoutSubject.eraseToAnyPublisher()
    }
}
