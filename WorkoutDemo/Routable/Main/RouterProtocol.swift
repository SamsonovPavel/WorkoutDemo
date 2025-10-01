//
//  RouterProtocol.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit

protocol RouterProtocol {
    associatedtype RootController: UIViewController
    var rootController: RootController { get }
}

extension RouterProtocol {
    
    func present(_ routable: RoutableProtocol) {
        present(routable, animated: true)
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true) {
        rootController.present(viewController, animated: animated)
    }
    
    func present(_ routable: RoutableProtocol, animated: Bool) {
        rootController.present(routable.source, animated: animated)
    }
    
    func present(_ viewController: UIViewController, presentationStyle: UIModalPresentationStyle, animated: Bool = true) {
        if rootController.presentedViewController == nil {
            viewController.modalPresentationStyle = presentationStyle
            present(viewController, animated: animated)
        }
    }
    
    func dismiss(animated: Bool, completion: VoidBlock? = nil) {
        rootController.dismiss(
            animated: animated,
            completion: completion
        )
    }
    
    func dismissPresentedViewController(animated: Bool, completion: VoidBlock? = nil) {
        if let presentedViewController = rootController.presentedViewController {
            presentedViewController.dismiss(
                animated: animated,
                completion: completion
            )
        }
    }
}
