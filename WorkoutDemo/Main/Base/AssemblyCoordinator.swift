//
//  AssemblyCoordinator.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Combine
import Swinject

protocol AssemblyProtocol {
    var assembler: Assembler { get }
    var resolver: Resolver { get }
    
    func assemblies() -> [Assembly]
}

/// Базовый координатор для работы с `Swinject`.
class AssemblyCoordinator<T>: BaseCoordinator<T>, AssemblyProtocol {
    
    /// Ассемблер
    lazy var assembler: Assembler = {
        Assembler(assemblies())
    }()
    
    /// Извлекает зависимость с указанным типом сервиса.
    var resolver: Resolver {
        assembler.resolver
    }
    
    /// Массив зависимостей
    func assemblies() -> [Assembly] {
        fatalError("must be overridden")
    }

    /// Запускает и освобождает координатор,
    /// добавляя зависимости родительского координатора
    /// - Parameter coordinator: Новый координатор
    /// - Returns: AnyPublisher с определенным типом. Вызывается в момент окончания его `Flow`
    @discardableResult
    override func coordinate<Coordinator: BaseCoordinateProtocol, Result>(to coordinator: Coordinator) -> AnyPublisher<Result, Never> where Result == Coordinator.T {
        if let coordinator = coordinator as? AssemblyProtocol {
            let assembler = coordinator.assembler
            assembler.apply(assemblies: assemblies())
        }
        
        return super.coordinate(to: coordinator)
    }
}
