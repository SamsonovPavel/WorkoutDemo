//
//  HomeViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class HomeViewController: BaseViewController {
    
    private let addWorkoutSubject = PassthroughSubject<Void, Never>()
    
    private let viewModel: HomeViewModelProtocol
    
    private var modelOutput: HomeViewModel.Output {
        let modelInput = HomeViewModel.Input(
            addWorkoutPublisher: addWorkoutSubject
                .eraseToAnyPublisher()
        )

        return viewModel.bind(modelInput)
    }

    init(_ model: HomeViewModelProtocol) {
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
        _ = modelOutput
    }
    
    private func setupTabBar() {
        tabBarItem = UITabBarItem(
            title: TabItemType.home.title,
            image:  TabItemType.home.icon,
            selectedImage:  TabItemType.home.icon
        )
    }
}

// MARK: - Preview

#if DEBUG
extension HomeViewController {
    
    convenience init() {
        self.init(HomeViewModel())
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
            .preview()
    }
}
#endif
