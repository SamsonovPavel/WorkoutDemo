//
//  LoginViewModel.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Foundation
import Combine

protocol LoginViewModelProtocol {
    func bind(_ input: LoginViewModelInput)
}

// MARK: - Input

struct LoginViewModelInput {
    let success: AnyPublisher<String, Never>
}

// MARK: - ViewModel

final class LoginViewModel: LoginViewModelProtocol {
    
    private let completeSubject = PassthroughSubject<Void, Never>()
    private var bindings = Set<AnyCancellable>()

    func bind(_ input: LoginViewModelInput) {
        input.success
            .receive(on: .mainQueue)
            .sink { [unowned self] loginName in
                UserDefaults.loginName = loginName
                completeSubject.send()
                
            }.store(in: &bindings)
    }
}

extension LoginViewModel: LoginModuleOutput {
    var succesLogin: AnyPublisher<Void, Never> {
        completeSubject.eraseToAnyPublisher()
    }
}
