//
//  SplashViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class SplashViewController: BaseViewController {
    
    private let runLoadSubject = PassthroughSubject<Void, Never>()
    
    private let logoImageView: UIImageView
    private let viewModel: SplashViewModelProtocol
    
    init(_ viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        
        logoImageView = .init(
            image: UIImage(
                systemName: "figure.run"
            )
        )

        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
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
            SplashViewModel.Input(
                run: runLoadSubject.eraseToAnyPublisher()
            )
        )
    }
    
    private func run() {
        runLoadSubject.send(())
    }
}

// MARK: - Preview

#if DEBUG
extension SplashViewController {
    
    convenience init() {
        self.init(SplashViewModel())
    }
}

struct SplashViewController_Previews: PreviewProvider {
    static var previews: some View {
        SplashViewController()
            .preview()
            .ignoresSafeArea()
    }
}
#endif
