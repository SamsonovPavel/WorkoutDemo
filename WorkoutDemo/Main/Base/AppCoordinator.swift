//
//  AppCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine

class AppCoordinator: BaseCoordinator<Void> {
    
    @Published private(set) var stateType: StateType
    
    private let window: UIWindow
    private let route = Factory.route
    
    override var source: UIViewController {
        window.rootViewController!
    }
    
    private var router: Router {
        route.createRouter()
    }
    
    private var tabRouter: TabRouter {
        route.createTabRouter()
    }
    
    private var isUserLogged: Bool {
        UserDefaults.loginName.isEmpty == false
    }

    enum StateType {
        case login
        case splash
        case onboarding
        case tabBar(TabItemType)
    }
    
    init(_ window: UIWindow) {
        self.window = window
        stateType = .splash
    }

    @discardableResult
    override func start() -> AnyPublisher<Void, Never> {
        $stateType
            .sink { [unowned self] state in
                switch state {
                case .login: startLoginCoordinator()
                case .splash: startSplashCoordinator()
                case .onboarding: startOnboardingCoordinator()
                case .tabBar(let tab): startTabCoordinator(tab)
                }
                
            }.store(in: &bindings)

        return asEmpty()
    }

    private func startSplashCoordinator() {
        let coordinator = SplashCoordinator(router: router)
        
        routeTo(coordinator, window: window)
            .receive(on: .mainQueue)
            .sink(receiveValue: startRoute)
            .store(in: &bindings)
    }

    private func startOnboardingCoordinator() {
        let coordinator = OnboardingCoordinator(router: router)
        
        routeTo(coordinator, window: window)
            .receive(on: .mainQueue)
            .sink(receiveValue: routeToState)
            .store(in: &bindings)
    }
    
    private func startLoginCoordinator() {
        let coordinator = LoginCoordinator(router: router)
        
        routeTo(coordinator, window: window)
            .receive(on: .mainQueue)
            .sink(receiveValue: startTabMain)
            .store(in: &bindings)
    }
    
    private func startTabCoordinator(_ tabItemType: TabItemType) {
        let coordinator = TabBarCoordinator(
            tabItemType: tabItemType,
            router: tabRouter
        )
        
        routeTo(coordinator, window: window)
            .receive(on: .mainQueue)
            .sink(receiveValue: routeToState)
            .store(in: &bindings)
    }
    
    // MARK: - Route
    
    private func startRoute() {
        stateType = .onboarding
    }

    private func startTabMain() {
        stateType = .tabBar(.home)
    }
    
    private func routeToState() {
        if isUserLogged {
            startTabMain()
        } else {
            stateType = .login
        }
    }
}

extension AppCoordinator {
    @discardableResult
    private func routeTo<Coordinator: BaseCoordinateProtocol, T>(
        _ coordinator: Coordinator,
        window: UIWindow,
        animated: Bool = true
    ) -> AnyPublisher<T, Never> where T == Coordinator.T {
        let coordinate = coordinate(to: coordinator)
        
        window.rootViewController = coordinator.source
        window.makeKeyAndVisible()
        
        if animated {
            UIView.transition(
                with: window,
                duration: 0.2,
                options: .transitionCrossDissolve,
                animations: nil
            )
        }
        
        return coordinate.eraseToAnyPublisher()
    }
}
