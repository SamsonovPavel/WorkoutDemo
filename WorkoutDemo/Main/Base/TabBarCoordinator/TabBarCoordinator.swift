//
//  TabBarCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine

class TabBarCoordinator: BaseCoordinator<Void> {
    
    private let complete = PassthroughSubject<Void, Never>()
    
    private let router: TabRouter
    private let tabItemType: TabItemType
    private var tabItems: [TabItemType: TabBarItemCoordinator]
    
    override var source: UITabBarController {
        router.rootController
    }
    
    enum Action {
        case addWorkout(Int)
        case resetBadge
        case logout
    }
    
    init(tabItemType: TabItemType, router: TabRouter) {
        self.tabItemType = tabItemType
        self.router = router
        
        tabItems = [:]
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let tabItems = createTabItems()
        
        tabItems.forEach { tabItem in
            coordinate(to: tabItem)
        }
        
        let viewControllers = tabItems.compactMap { $0.source }
        router.setViewControllers(viewControllers)
        
        switchTo(tabItemType)
        bind()
        
        return complete.eraseToAnyPublisher()
    }
    
    private func bind() {
        for tabItem in tabItems {
            tabItem.value.didTabAction
                .receive(on: .mainQueue)
                .sink { [unowned self] action in
                    switch action {
                    case .addWorkout(let count):
                        updateListWorkout(count: count)
                        
                    case .resetBadge: resetBatch()
                    case .logout: logout()
                    }
                    
                }.store(in: &bindings)
        }
    }
}

extension TabBarCoordinator {
    
    private func createTabItems() -> [TabBarItemCoordinator] {
        let homeTabItem = HomeTabItemCoordinator(router: Factory.route.createRouter())
        let listTabItem = ListTabItemCoordinator(router: Factory.route.createRouter())
        let aboutTabItem = AboutAppTabItemCoordinator(router: Factory.route.createRouter())
        
        tabItems = [
            .home: homeTabItem,
            .listWorkout: listTabItem,
            .aboutApp: aboutTabItem
        ]
        
        return TabItemType.allCases.map { tabItemType in
            switch tabItemType {
            case .home: homeTabItem
            case .listWorkout: listTabItem
            case .aboutApp: aboutTabItem
            }
        }
    }
    
    private func switchTo(_ tab: TabItemType) {
        router.didSelectTab(tab)
    }
}

extension TabBarCoordinator {
    
    private func updateListWorkout(count: Int) {
        guard let listTabItem = tabItems[.listWorkout],
              let coordinator = listTabItem as? ListTabItemCoordinator else {
            return
        }
        
        router.updateBadgeValue(.listWorkout, value: count)
        coordinator.updateListWorkout()
    }
    
    private func resetBatch() {
        router.resetBadgeValue()
    }
    
    private func logout() {
        complete.send()
    }
}
