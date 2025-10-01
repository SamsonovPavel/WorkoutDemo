//
//  RouteFactory.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit

struct RouteFactory {
    
    func createRouter() -> Router {
        let root = UINavigationController()
        let router = Router(rootController: root)
        
        return router
    }
    
    func createTabRouter() -> TabRouter {
        let root = TabBarViewController()
        let router = TabRouter(rootController: root)

        return router
    }
}
