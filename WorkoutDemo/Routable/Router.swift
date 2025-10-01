//
//  Router.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit

class Router: RouterProtocol {
    let rootController: UINavigationController
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
}

extension RouterProtocol where RootController == UINavigationController {
    
    var topViewController: UIViewController? {
        rootController.topViewController
    }
    
    var viewControllers: [UIViewController] {
        rootController.viewControllers
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        rootController.setViewControllers([viewController], animated: false)
    }
    
    func setModalPresentationStyle(style: UIModalPresentationStyle) {
        rootController.modalPresentationStyle = style
    }
    
    /// Push для координатора
    func routeTo(_ routable: RoutableProtocol, animated: Bool = true) {
        rootController.pushViewController(
            routable.source,
            animated: animated
        )
    }
    
    func pushTo(_ viewController: UIViewController, animated: Bool = true, navigationBarHide: Bool) {
        rootController.setNavigationBarHidden(navigationBarHide, animated: animated)
        rootController.pushViewController(viewController, animated: animated)
    }
    
    func pushTo(_ viewController: UIViewController, animated: Bool = true) {
        rootController.pushViewController(viewController, animated: animated)
    }

    func popToRootViewController(animated: Bool = true) {
        rootController.popToRootViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        dismissPresentedViewController(animated: animated)
        rootController.popToRootViewController(animated: animated)
    }
    
    func popTo(_ viewController: UIViewController, animated: Bool = true) {
        dismissPresentedViewController(animated: animated)
        rootController.popToViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        dismissPresentedViewController(animated: animated)
        rootController.popViewController(animated: true)
    }
}
