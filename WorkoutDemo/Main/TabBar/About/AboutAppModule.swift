//
//  AboutAppModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine

protocol AboutAppModuleOutput {
    var didSelectRow: AnyPublisher<Void, Never> { get }
    var didExit: AnyPublisher<Void, Never> { get }
}

class AboutAppModule: OutputModule<AboutAppModuleOutput> {}
