//
//  Scheduler+Main.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import Foundation
import Combine

extension Scheduler where Self == DispatchQueue {
    
    static var mainQueue: DispatchQueue {
        .main
    }
}
