//
//  BottomSheetPresentController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import UIKit
import Combine
import SnapKit

class BottomSheetPresentController: BasePresentationController {
    
    private var tapGesturePublisher: AnyPublisher<Void, Never> {
        dimmingView.tapGesturePublisher
            .merge(with: topPullView.tapGesturePublisher)
            .merge(with: pullView.tapGesturePublisher)
            .mapToVoid()
            .eraseToAnyPublisher()
    }
    
    private let transitioningDelegate: BottomSheetTransitionDelegate
    
    private lazy var topPullView = UIView(backgroundColor: .clear)
    private lazy var pullView = UIView(backgroundColor: .black.withAlphaComponent(0.5))
    private lazy var dimmingView = UIView(backgroundColor: .black.withAlphaComponent(0.2))
    
    private var bindings = Set<AnyCancellable>()

    init(presented: UIViewController, presenting: UIViewController?, transitioningDelegate: BottomSheetTransitionDelegate) {
        self.transitioningDelegate = transitioningDelegate
        
        super.init(presentedViewController: presented, presenting: presenting)
        setupPresentedView()
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView,
              let presentedView = presentedView else {
            return
        }
        
        containerView.addSubview(dimmingView)
        
        presentedView.addSubviews(
            topPullView.addSubviews(
                pullView
            )
        )
        
        dimmingView.alpha = 0
        
        if let transitionCoordinator = presentedViewController.transitionCoordinator {
            transitionCoordinator.animate { [weak self] _ in
                guard let self else { return }
                
                presentedView.layer.cornerRadius = 16
                dimmingView.alpha = 1
            }
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        guard let presentedView = presentedView else {
            return
        }
        
        if let transitionCoordinator = presentedViewController.transitionCoordinator {
            transitionCoordinator.animate { [weak self] _ in
                guard let self else { return }
                presentedView.layer.cornerRadius = .zero
                
                dimmingView.alpha = 0
            }
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        setupViews()
    }
    
    private func setupViews() {
        guard let containerView = containerView,
              let presentedView = presentedView else {
            return
        }
        
        dimmingView.frame = containerView.bounds
        pullView.layer.cornerRadius = pullView.frame.height / 2
        
        presentedView.layer.cornerCurve = .continuous
        presentedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        presentedView.frame = frameOfPresentedViewInContainerView
        presentedView.clipsToBounds = true
        
        presentedViewController.additionalSafeAreaInsets.top = pullView.frame.maxY
        
        topPullView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(20)
        }
        
        pullView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.size.equalTo(CGSize(width: 32, height: 4))
        }
    }
    
    private func setupPresentedView() {
        guard let presentedView = presentedView else { return }
        
        presentedView.panGesturePublisher
            .sink(receiveValue: handlePanGestureRecognizer)
            .store(in: &bindings)
        
        tapGesturePublisher
            .sink(receiveValue: handleTapGestureRecognizer)
            .store(in: &bindings)
    }
    
    private func handlePanGestureRecognizer(_ recognizer: UIPanGestureRecognizer) {
        guard let presentedView = presentedView else { return }
        
        switch recognizer.state {
        case .began: dismiss(isInteractive: true)
        case .changed: updateTransition(for: recognizer.translation(in: presentedView))
        case .ended, .cancelled, .failed: endedTransition()

        default:
            break
        }
    }
    
    private func handleTapGestureRecognizer() {
        dismiss(isInteractive: false)
    }
    
    private func dismiss(isInteractive: Bool) {
        transitioningDelegate.animatedTransition.wantsInteractiveStart = isInteractive
        presentedViewController.dismiss(animated: true)
    }
    
    private func updateTransition(for translation: CGPoint) {
        guard let presentedView = presentedView else { return }
        
        let totalHeight = presentedView.frame.height - translation.y
        let progress = 1 - (totalHeight / presentedView.frame.height)
        
        transitioningDelegate.animatedTransition.update(progress)
    }
    
    private func endedTransition() {
        let animatedTransition = transitioningDelegate.animatedTransition
        animatedTransition.wantsInteractiveStart = false
        
        if animatedTransition.fractionComplete > 0.3 {
            animatedTransition.finish()
        } else {
            animatedTransition.cancel()
        }
    }
}
