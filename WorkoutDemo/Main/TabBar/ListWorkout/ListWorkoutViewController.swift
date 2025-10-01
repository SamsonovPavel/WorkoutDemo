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
    
    private let addWorkoutSubject = PassthroughSubject<Void, Never>()
    
    private let viewModel: ListWorkoutViewModelProtocol
    
    private var modelOutput: ListWorkoutViewModel.Output {
        viewModel.bind()
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

    private func setupViews() {
        view.backgroundColor = .white
    }
    
    private func makeConstraints() {}

    private func bind() {
        modelOutput.addWorkoutPublisher
            .receive(on: .mainQueue)
            .sink { _ in
            }.store(in: &bindings)
    }
    
    private func setupTabBar() {
        tabBarItem = UITabBarItem(
            title: TabItemType.listWorkout.title,
            image:  TabItemType.listWorkout.icon,
            selectedImage:  TabItemType.listWorkout.icon
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
