//
//  TabBarItemCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine
import Swinject

class TabBarItemCoordinator: AssemblyCoordinator<Void> {
    
    private let didTabActionSubject = PassthroughSubject<TabBarCoordinator.Action, Never>()
    
    var didTabAction: AnyPublisher<TabBarCoordinator.Action, Never> {
        didTabActionSubject.eraseToAnyPublisher()
    }
    
    let router: Router
    
    override var source: UINavigationController {
        router.rootController
    }

    init(router: Router) {
        self.router = router
        super.init()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        resolver.resolved(type)
    }

    func resolve<T, Arg1>(_ type: T.Type, argument: Arg1) -> T {
        resolver.resolved(type, argument: argument)
    }
}

extension TabBarItemCoordinator {
 
    func addNewWorkoutAction(_ count: Int) {
        didTabActionSubject.send(.addWorkout(count))
    }
}
