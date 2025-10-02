//
//  ListTabItemCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine
import Swinject

class ListTabItemCoordinator: TabBarItemCoordinator {
    
    /// Главный экран
    private var listWorkoutModule: ListWorkoutModule {
        resolve(ListWorkoutModule.self)
    }
    
    // Другие модули экранов
 
    override func assemblies() -> [Assembly] {
        ListTabAssembly.assemblies
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        showHomeTabScreen()
        return asEmpty()
    }
    
    private func bind(_ module: ListWorkoutModule) {}
}

extension ListTabItemCoordinator {
    
    func updateListWorkout() {
        listWorkoutModule.input.updateList()
    }
 
    private func showHomeTabScreen() {
        let module = listWorkoutModule
        bind(module)
        
        router.setRootViewController(module.viewController)
    }
}
