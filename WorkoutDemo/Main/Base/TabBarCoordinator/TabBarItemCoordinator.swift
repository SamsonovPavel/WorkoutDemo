//
//  TabBarItemCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Swinject

class TabBarItemCoordinator: AssemblyCoordinator<Void> {
    
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
