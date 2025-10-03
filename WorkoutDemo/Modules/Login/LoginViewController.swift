//
//  LoginViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class LoginViewController: BaseViewController {
    
    private var workoutButtonPublisher: AnyPublisher<String, Never> {
        workoutButton.publisher(for: .touchUpInside)
            .map { _ in self.titleTextFieldView.textString ?? "" }
            .eraseToAnyPublisher()
    }

    private let viewModel: LoginViewModelProtocol
    private lazy var titleTextFieldView = TitleTextFieldView(style: .name)
    
    private let workoutButton = WorkoutButton(
        style: .login
    )
    
    init(_ viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind()
    }

    private func setupViews() {
        view.addSubviews(
            titleTextFieldView,
            workoutButton
        )
        
        titleTextFieldView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.centerY.equalToSuperview().offset(-132)
            make.height.equalTo(64)
        }
        
        workoutButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.top.equalTo(titleTextFieldView.snp.bottom).offset(32)
            make.height.equalTo(48)
        }
        
        view.backgroundColor = .white
    }
    
    private func bind() {
        viewModel.bind(
            LoginViewModelInput(
                success: workoutButtonPublisher
            )
        )
    }
}

// MARK: - Preview

#if DEBUG
extension LoginViewController {
    
    convenience init() {
        self.init(LoginViewModel())
    }
}

struct LoginViewController_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewController()
            .preview()
            .previewLayout(.sizeThatFits)
    }
}
#endif
