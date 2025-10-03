//
//  LoginCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import UIKit
import Combine

final class LoginCoordinator: BaseCoordinator<Void> {
    
    private let router: Router
    private let complete = PassthroughSubject<Void, Never>()
    
    private var topViewController: UIViewController? {
        router.topViewController
    }
    
    override var source: UINavigationController {
        router.rootController
    }
    
    private lazy var loginModule: LoginModule = {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel)
        
        return LoginModule(
            output: viewModel,
            viewController: viewController
        )
    }()
    
    init(router: Router) {
        self.router = router
        super.init()
        
        bind(loginModule)
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        showLoginScreen()
        return complete.eraseToAnyPublisher()
    }
    
    // MARK: - Bind
    
    private func bind(_ module: LoginModule) {
        module.output
            .succesLogin
            .receive(on: .mainQueue)
            .sink(receiveValue: complete.send)
            .store(in: &bindings)
    }
    
    private func showLoginScreen() {
        let module = loginModule
        
        router.setRootViewController(
            module.viewController
        )
    }
}
