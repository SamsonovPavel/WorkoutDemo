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
    
    private let newWorkoutView = NewWorkoutView()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private var modelOutput: HomeViewModel.Output {
        let modelInput = HomeViewModel.Input(
            addWorkoutPublisher: newWorkoutView.addWorkoutPublisher
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
        view.addSubviews(
            newWorkoutView,
            userNameLabel
        )
        
        newWorkoutView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(-UIScreen.main.bounds.height / 4)
            make.height.equalTo(220)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(80)
        }
        
        userNameLabel.text = UserDefaults.loginName
        view.backgroundColor = .white
    }
    
    private func makeConstraints() {}

    private func bind() {
        _ = modelOutput
    }
    
    private func setupTabBar() {
        tabBarItem = Factory.tabBar.createTabBarItem(
            tabItemType: .home
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
