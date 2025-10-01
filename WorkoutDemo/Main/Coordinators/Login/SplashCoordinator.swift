//
//  SplashCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine

class SplashCoordinator: BaseCoordinator<Void> {
 
    private let router: Router
    
    override var source: UIViewController {
        router.rootController
    }
    
    private var splashModule: SplashModule {
        let viewModel = SplashViewModel()
        let viewController = SplashViewController(viewModel)
        
        return SplashModule(
            output: viewModel,
            viewController: viewController
        )
    }
    
    init(router: Router) {
        self.router = router
        super.init()
        
        bind()
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let module = splashModule
        router.setRootViewController(module.viewController)
        
        return module.output.completePublisher
    }
    
    private func bind() {}
}
