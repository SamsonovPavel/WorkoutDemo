//
//  HomeTabAssembly.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Swinject

class HomeTabAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeModule.self) { resolver in
            let viewModel = HomeViewModel()
            let viewController = HomeViewController(viewModel)
            
            return HomeModule(
                output: viewModel,
                viewController: viewController
            )
        }

        // Регистрация других модулей
    }
}

extension HomeTabAssembly {
 
    static let assemblies: [Assembly] = [
        HomeTabAssembly()
    ]
}
