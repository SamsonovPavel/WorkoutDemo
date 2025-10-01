//
//  Publisher+Map.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import Combine

extension Publisher {

    func mapToVoid() -> Publishers.Map<Self, Void> {
        return map { _ in }
    }
}
