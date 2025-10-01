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
    
    private let didSelectRowSubject = PassthroughSubject<Void, Never>()
    private let didExitSubject = PassthroughSubject<Void, Never>()
    
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
        view.backgroundColor = .white
    }
    
    private func makeConstraints() {}

    private func bind() {
        viewModel.bind(
            AboutAppViewModel.Input(
                didSelectRow: didSelectRowSubject.eraseToAnyPublisher(),
                didExit: didExitSubject.eraseToAnyPublisher()
            )
        )
    }
    
    private func setupTabBar() {
        tabBarItem = UITabBarItem(
            title: TabItemType.aboutApp.title,
            image:  TabItemType.aboutApp.icon,
            selectedImage:  TabItemType.aboutApp.icon
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
