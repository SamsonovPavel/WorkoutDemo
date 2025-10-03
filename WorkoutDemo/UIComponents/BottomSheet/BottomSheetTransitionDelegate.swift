//
//  BottomSheetTransitionDelegate.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import UIKit

class BottomSheetTransitionDelegate: NSObject {
    
    let animatedTransition = BottomSheetAnimatedTransition()
    
    private func presentAnimatedTransitioning() -> BottomSheetAnimatedTransition {
        animatedTransition.wantsInteractiveStart = false
        animatedTransition.isPresenting = true

        return animatedTransition
    }
    
    private func dismissAnimatedTransitioning() -> BottomSheetAnimatedTransition {
        animatedTransition.isPresenting = false
        return animatedTransition
    }
}

extension BottomSheetTransitionDelegate: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        BottomSheetPresentController(
            presented: presented,
            presenting: presenting,
            transitioningDelegate: self
        )
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentAnimatedTransitioning()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        dismissAnimatedTransitioning()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        dismissAnimatedTransitioning()
    }
}
