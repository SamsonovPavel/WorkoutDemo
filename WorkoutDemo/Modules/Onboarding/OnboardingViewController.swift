//
//  OnboardingViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class OnboardingViewController: BaseViewController {
    
    private let runLoadSubject = PassthroughSubject<Void, Never>()
    
    private let logoImageView: UIImageView
    private let keyAnimation: String
    
    private let viewModel: OnboardingViewModelProtocol
    
    init(_ viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
        
        logoImageView = .init(
            image: UIImage(
                systemName: "figure.run"
            )
        )

        keyAnimation = "keyAnimation"

        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addAnimation()
        bind()
        run()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(logoImageView)

        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(64)
        }
    }
    
    private func bind() {
        _ = viewModel.bind(
            OnboardingViewModel.Input(
                run: runLoadSubject.eraseToAnyPublisher()
            )
        )
    }
    
    private func run() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.removeAnimation()
            self.runLoadSubject.send(())
        }
    }
    
    private func addAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 0.48
        animation.autoreverses = true
        animation.isRemovedOnCompletion = false
        animation.fromValue = 0
        animation.toValue = 16
        animation.timingFunction = .init(name: .easeInEaseOut)
        animation.repeatCount = .infinity
        
        logoImageView.layer.add(animation, forKey: keyAnimation)
    }

    private func removeAnimation() {
        if logoImageView.layer.animation(forKey: keyAnimation) != nil {
            logoImageView.layer.removeAnimation(
                forKey: keyAnimation
            )
        }
    }
}

// MARK: - Preview

#if DEBUG
extension OnboardingViewController {
    
    convenience init() {
        self.init(OnboardingViewModel())
    }
}

struct OnboardingViewController_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingViewController()
            .preview()
            .ignoresSafeArea()
    }
}
#endif
