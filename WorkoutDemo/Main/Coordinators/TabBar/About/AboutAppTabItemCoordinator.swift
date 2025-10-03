//
//  AboutAppTabItemCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine
import Swinject

class AboutAppTabItemCoordinator: TabBarItemCoordinator {
    
    private lazy var aboutAppModule = resolve(
        AboutAppModule.self
    )
    
    override func assemblies() -> [Assembly] {
        AboutAppTabAssembly.assemblies
    }
    
    override init(router: Router) {
        super.init(router: router)
        bind(aboutAppModule)
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        showAboutAppScreen()
        
        return asEmpty()
    }
    
    private func bind(_ module: AboutAppModule) {
        module.output
            .didSelectRow
            .receive(on: .mainQueue)
            .sink { _ in
            }.store(in: &bindings)
        
        module.output
            .logoutPublisher
            .receive(on: .mainQueue)
            .sink(receiveValue: logoutAction)
            .store(in: &bindings)
    }
}

extension AboutAppTabItemCoordinator {
    
    private func showAboutAppScreen() {
        let module = aboutAppModule
        bind(module)
        
        router.setRootViewController(module.viewController)
    }
}
