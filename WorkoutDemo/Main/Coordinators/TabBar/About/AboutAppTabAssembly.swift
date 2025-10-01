//
//  AboutAppTabAssembly.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Swinject

class AboutAppTabAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AboutAppModule.self) { resolver in
            let viewModel = AboutAppViewModel()
            let viewController = AboutAppViewController(viewModel)
            
            return AboutAppModule(
                output: viewModel,
                viewController: viewController
            )
        }
    }
}

extension AboutAppTabAssembly {
 
    static let assemblies: [Assembly] = [
        AboutAppTabAssembly()
    ]
}
