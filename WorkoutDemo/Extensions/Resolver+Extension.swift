//
//  Resolver+Extension.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Swinject

extension Resolver {
    
    func resolved<T>(_ type: T.Type) -> T {
        return resolve(type)!
    }

    func resolved<T, Arg1>(_ type: T.Type, argument: Arg1) -> T {
        return resolve(type, argument: argument)!
    }
}
