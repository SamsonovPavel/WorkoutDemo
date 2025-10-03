//
//  BottomSheetAnimatedTransition.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import UIKit

// MARK: - Transition

class BottomSheetAnimatedTransition: UIPercentDrivenInteractiveTransition {
    
    private let animationDuration: TimeInterval = 0.5
    private let dampingRatio: Double = 0.9
    
    private var presentAnimator: UIViewPropertyAnimator?
    private var dismissAnimator: UIViewPropertyAnimator?
    
    var isPresenting = true
    
    var fractionComplete: CGFloat {
        if let dismissAnimator = dismissAnimator {
            return dismissAnimator.fractionComplete
        }

        return .zero
    }
}

extension BottomSheetAnimatedTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        interruptibleAnimator(using: transitionContext)
            .startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if isPresenting {
            return presentAnimator(transitionContext)
        } else {
            return dismissAnimator(transitionContext)
        }
    }
}

// MARK: - Presented

extension BottomSheetAnimatedTransition {
    private func presentAnimator(_ transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if let presentAnimator = presentAnimator {
            return presentAnimator
        } else {
            return createPresentAnimator(transitionContext)
        }
    }
    
    private func createPresentAnimator(_ transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating {
        let animator = UIViewPropertyAnimator(
            duration: transitionDuration(using: transitionContext),
            dampingRatio: dampingRatio
        )
        
        presentAnimator = animator
        
        guard let viewController = transitionContext.viewController(forKey: .to),
              let view = transitionContext.view(forKey: .to) else {
            return animator
        }
        
        view.frame = transitionContext.finalFrame(for: viewController)
        view.frame.origin.y = transitionContext.containerView.frame.maxY
        
        transitionContext.containerView.addSubview(view)
        
        animator.addAnimations {
            view.frame = transitionContext.finalFrame(
                for: viewController
            )
        }
        
        animator.addCompletion { [weak self] position in
            guard let self else { return }
            presentAnimator = nil
            
            guard case .end = position else {
                transitionContext.completeTransition(false)
                return
            }
            
            transitionContext.completeTransition(
                transitionContext.transitionWasCancelled == false
            )
        }
        
        return animator
    }
}

// MARK: - Dismissed

extension BottomSheetAnimatedTransition {
    private func dismissAnimator(_ transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating {
        if let dismissAnimator = dismissAnimator {
            return dismissAnimator
        } else {
            return createDismissAnimator(transitionContext)
        }
    }
    
    private func createDismissAnimator(_ transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating {
        let animator = UIViewPropertyAnimator(
            duration: transitionDuration(using: transitionContext),
            dampingRatio: dampingRatio
        )
        
        dismissAnimator = animator
        
        guard let view = transitionContext.view(forKey: .from) else {
            return animator
        }
        
        animator.addAnimations {
            view.frame.origin.y = view.frame.maxY
        }
        
        animator.addCompletion { [weak self] position in
            guard let self else { return }
            dismissAnimator = nil
            
            guard case .end = position else {
                transitionContext.completeTransition(false)
                return
            }
            
            view.removeFromSuperview()
            transitionContext.completeTransition(
                transitionContext.transitionWasCancelled == false
            )
        }
        
        return animator
    }
}
