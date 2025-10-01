//
//  BaseCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine

protocol RoutableProtocol {
    var source: UIViewController { get }
}

protocol BaseCoordinateProtocol: AnyObject, RoutableProtocol {
    associatedtype T
    
    var identifier: UUID { get }
    func start() -> AnyPublisher<T, Never>
}

protocol DeepLinkProtocol {
    func handleDeeplink(_ url: URL)
}

/// Базовый координатор
class BaseCoordinator<T>: BaseCoordinateProtocol, DeepLinkProtocol {

    /// Уникальный идентификатор координатора
    let identifier = UUID()
    
    /// Контроллер представления
    var source: UIViewController {
        fatalError("must be overridden")
    }
    
    /// Словарь `child`-координаторов.
    private var childCoordinators: [UUID: Any] = [:]
    
    var bindings = Set<AnyCancellable>()

    /// Абстрактный метод. Запускает координатор.
    /// - Returns: AnyPublisher с определенным типом. Вызывается в момент окончания его flow
    func start() -> AnyPublisher<T, Never> {
        fatalError("must be overridden")
    }

    /// Абстрактный метод. Обрабатывает диплинки.
    func handleDeeplink(_ url: URL) {
        fatalError("must be overridden")
    }
    
    /// Запускает и освобождает координатор
    /// - Parameter coordinator: Новый координатор
    /// - Returns: AnyPublisher с определенным типом. Вызывается в момент окончания его flow
    @discardableResult func coordinate<Coordinator: BaseCoordinateProtocol, Result>(to coordinator: Coordinator) -> AnyPublisher<Result, Never> where Result == Coordinator.T {
        store(coordinator: coordinator)
        
        return coordinator.start()
            .first()
            .handleEvents(receiveOutput: { [unowned self] _ in
                free(coordinator: coordinator)
            }).eraseToAnyPublisher()
    }

    /// Добавляет координатор
    private func store<Coordinator: BaseCoordinateProtocol>(coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    /// Освобождает координатор
    private func free<Coordinator: BaseCoordinateProtocol>(coordinator: Coordinator) {
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }
    
    /// Освобождает все координаторы
    func cleanChildCoordinators() {
        childCoordinators.removeAll()
    }
    
    /// Возвращает координатор по типу
    func childCoordinator<Coordinator>(coordinatorType: Coordinator.Type) -> T? {
        let coordinator = childCoordinators.values.first(where: { $0 is T })
        return coordinator as? T
    }
}

extension BaseCoordinator {
    
    func asEmpty() -> AnyPublisher<Void, Never> {
        Empty().eraseToAnyPublisher()
    }
}
