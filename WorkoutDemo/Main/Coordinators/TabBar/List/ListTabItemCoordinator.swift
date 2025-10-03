//
//  ListTabItemCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine
import Swinject

class ListTabItemCoordinator: TabBarItemCoordinator {
    
    /// Главный экран
    private var listWorkoutModule: ListWorkoutModule {
        resolve(ListWorkoutModule.self)
    }
    
    // Другие модули экранов
    
    private let transitionDelegate = BottomSheetTransitionDelegate()
 
    override func assemblies() -> [Assembly] {
        ListTabAssembly.assemblies
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        showHomeTabScreen()
        return asEmpty()
    }
    
    private func bind(_ module: ListWorkoutModule) {
        module.output
            .didSelectRow
            .receive(on: .mainQueue)
            .sink { [unowned self] rowType in
                switch rowType {
                case .cell(let model):
                    showDetailScreen(model)
                }
                
            }.store(in: &bindings)
        
        module.output
            .resetBadge
            .receive(on: .mainQueue)
            .sink { [unowned self] in
                resetBadgeAction()
                
            }.store(in: &bindings)
    }
    
    private func bind(_ module: DetailModule) {
        module.output
            .startWorkout
            .receive(on: .mainQueue)
            .sink { [unowned self] model in
                showProgressScreen(model)
                
            }.store(in: &bindings)
    }
    
    private func bind(_ module: ProgressModule) {
        module.output
            .cancelWorkout
            .receive(on: .mainQueue)
            .sink(receiveValue: router.dismiss)
            .store(in: &bindings)
    }
}

extension ListTabItemCoordinator {
    
    func updateListWorkout() {
        listWorkoutModule.input.updateList()
    }
 
    private func showHomeTabScreen() {
        let module = listWorkoutModule
        bind(module)
        
        router.setRootViewController(module.viewController)
    }
    
    private func showDetailScreen(_ model: ListCollectionCell.Model) {
        let model = DetailViewModel.Model(
            title: model.title,
            date: model.date,
            duration: model.duration
        )
        
        let module = resolve(DetailModule.self, argument: model)
        bind(module)
        
        router.pushTo(module.viewController)
    }
    
    private func showProgressScreen(_ model: DetailViewModel.Model) {
        let model = ProgressViewModel.Model(
            title: model.title,
            date: model.date,
            duration: model.duration
        )
        
        let module = resolve(ProgressModule.self, argument: model)
        let viewController = module.viewController
        
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = transitionDelegate
        
        bind(module)
        
        router.present(viewController)
    }
}
