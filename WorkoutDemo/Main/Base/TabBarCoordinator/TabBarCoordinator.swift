//
//  TabBarCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine

class TabBarCoordinator: BaseCoordinator<Void> {
    
    private let router: TabRouter
    private let tabItemType: TabItemType
    private var tabItems: [TabItemType: TabBarItemCoordinator]
    
    override var source: UITabBarController {
        router.rootController
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
        
        return asEmpty()
    }
    
    private func bind() {}
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
