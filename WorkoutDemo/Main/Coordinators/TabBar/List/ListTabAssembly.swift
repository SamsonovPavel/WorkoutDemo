//
//  ListTabAssembly.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Swinject

class ListTabAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ListWorkoutModule.self) { resolver in
            let viewModel = ListWorkoutViewModel()
            let viewController = ListWorkoutViewController(viewModel)
            
            return ListWorkoutModule(
                input: viewModel,
                viewController: viewController
            )
            
        }.inObjectScope(.container)

        // Регистрация других модулей
    }
}

extension ListTabAssembly {
 
    static let assemblies: [Assembly] = [
        ListTabAssembly()
    ]
}
