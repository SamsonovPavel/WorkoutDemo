//
//  AboutAppViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class AboutAppViewController: BaseViewController {
    
    private var logoutButtonPublisher: AnyPublisher<Void, Never> {
        logoutButton.publisher(for: .touchUpInside)
            .mapToVoid()
            .eraseToAnyPublisher()
    }
    
    private let didSelectRowSubject = PassthroughSubject<Void, Never>()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = TabItemType.aboutApp.title
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    private let logoutButton = WorkoutButton(style: .logout)
    private let viewModel: AboutAppViewModelProtocol
    
    init(_ model: AboutAppViewModelProtocol) {
        viewModel = model
        
        super.init(nibName: nil, bundle: nil)
        setupTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind()
    }

    private func setupViews() {
        view.addSubviews(
            titleLabel,
            logoutButton
        )
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-150)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(108)
            make.height.equalTo(48)
        }
        
        view.backgroundColor = .white
    }
    
    private func makeConstraints() {}

    private func bind() {
        viewModel.bind(
            AboutAppViewModel.Input(
                didSelectRow: didSelectRowSubject.eraseToAnyPublisher(),
                logout: logoutButtonPublisher
            )
        )
    }
    
    private func setupTabBar() {
        tabBarItem = Factory.tabBar.createTabBarItem(
            tabItemType: .aboutApp
        )
    }
}

// MARK: - Preview

#if DEBUG
extension AboutAppViewController {
    
    convenience init() {
        self.init(AboutAppViewModel())
    }
}

struct AboutAppViewController_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppViewController()
            .preview()
    }
}
#endif
