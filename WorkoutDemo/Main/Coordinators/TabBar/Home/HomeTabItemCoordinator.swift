//
//  HomeTabItemCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine
import Swinject

class HomeTabItemCoordinator: TabBarItemCoordinator {
    
    /// Главный экран
    private var homeModule: HomeModule {
        resolve(HomeModule.self)
    }
    
    // Другие модули экранов
 
    override func assemblies() -> [Assembly] {
        HomeTabAssembly.assemblies
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        showHomeTabScreen()
        return asEmpty()
    }
    
    private func bind(_ module: HomeModule) {}
}

extension HomeTabItemCoordinator {
 
    func showHomeTabScreen() {
        let module = homeModule
        bind(module)
        
        router.setRootViewController(module.viewController)
    }
}
