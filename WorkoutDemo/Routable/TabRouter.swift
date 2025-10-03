//
//  TabRouter.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit

class TabRouter: RouterProtocol {
    let rootController: TabBarViewController

    init(rootController: TabBarViewController) {
        self.rootController = rootController
    }
}

extension RouterProtocol where RootController == TabBarViewController {
    var selectedViewController: UINavigationController? {
        rootController.selectedViewController as? UINavigationController
    }
    
    var visibleViewController: UIViewController? {
        if let selectedViewController = selectedViewController {
            return selectedViewController.visibleViewController
        } else {
            return nil
        }
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        rootController.setViewControllers(
            viewControllers,
            animated: false
        )
    }
    
    func didSelectTab(_ itemType: TabItemType) {
        rootController.didSelectTab(itemType)
    }
    
    func updateBadgeValue(_ itemType: TabItemType, value: Int) {
        rootController.updateBadgeValue(itemType, count: value)
    }
    
    func resetBadgeValue() {
        rootController.resetBadgeValue()
    }
}
