//
//  LoginModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Combine

protocol LoginModuleOutput {
    var succesLogin: AnyPublisher<Void, Never> { get }
}

class LoginModule: OutputModule<LoginModuleOutput> {}
