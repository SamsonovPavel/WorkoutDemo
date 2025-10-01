//
//  OnboardingCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine

class OnboardingCoordinator: BaseCoordinator<Void> {
 
    private let router: Router
    
    override var source: UIViewController {
        router.rootController
    }
    
    private var onboardingModule: OnboardingModule {
        let viewModel = OnboardingViewModel()
        let viewController = OnboardingViewController(viewModel)
        
        return OnboardingModule(
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
        let module = onboardingModule
        router.setRootViewController(module.viewController)
        
        return module.output.completePublisher
    }
    
    private func bind() {}
}
