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
                output: viewModel,
                viewController: viewController
            )
            
        }.inObjectScope(.container)

        container.register(DetailModule.self) { (resolver, model: DetailViewModel.Model) in
            let viewModel = DetailViewModel(model: model)
            let viewController = DetailViewController(viewModel)
            
            return DetailModule(
                output: viewModel,
                viewController: viewController
            )
        }
        
        container.register(ProgressModule.self) { (resolver, model: ProgressViewModel.Model) in
            let viewModel = ProgressViewModel(model: model)
            let viewController = ProgressViewController(viewModel)
            
            return ProgressModule(
                output: viewModel,
                viewController: viewController
            )
        }
    }
}

extension ListTabAssembly {
 
    static let assemblies: [Assembly] = [
        ListTabAssembly()
    ]
}
