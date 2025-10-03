//
//  ListWorkoutViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class ListWorkoutViewController: BaseViewController {
    
    private let resetBadgeSubject = PassthroughSubject<Void, Never>()
    
    private let collectionView = ListCollectionView()
    private lazy var dataSource = ListCollectionDataSource(collectionView)
    
    private let viewModel: ListWorkoutViewModelProtocol
    
    private var modelOutput: ListWorkoutViewModel.Output {
        viewModel.bind(
            ListWorkoutViewModel.Input(
                didSelectRow: collectionView.didSelectRow.eraseToAnyPublisher(),
                resetBadge: resetBadgeSubject.eraseToAnyPublisher()
            )
        )
    }

    init(_ model: ListWorkoutViewModelProtocol) {
        viewModel = model
        
        super.init(nibName: nil, bundle: nil)
        setupTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetBadgeSubject.send()
    }

    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        dataSource.reloadData()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
                .inset(16)
        }
    }

    private func bind() {
        modelOutput.addWorkoutPublisher
            .receive(on: .mainQueue)
            .sink { [unowned self] in
                dataSource.reloadData()
                
            }.store(in: &bindings)
    }
    
    private func setupTabBar() {
        tabBarItem = Factory.tabBar.createTabBarItem(
            tabItemType: .listWorkout
        )
    }
}

// MARK: - Preview

#if DEBUG
extension ListWorkoutViewController {
    
    convenience init() {
        self.init(ListWorkoutViewModel())
    }
}

struct ListWorkoutViewController_Previews: PreviewProvider {
    static var previews: some View {
        ListWorkoutViewController()
            .preview()
    }
}
#endif
