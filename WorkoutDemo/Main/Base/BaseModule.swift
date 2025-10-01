//
//  BaseModule.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit

// MARK: - Protocol

protocol InputModuleProtocol {
    associatedtype Input
    
    var input: Input { get }
    var viewController: UIViewController { get }
}

protocol OutputModuleProtocol {
    associatedtype Output
    
    var output: Output { get }
    var viewController: UIViewController { get }
}

// MARK: - Base

class BaseModule<Input, Output>: InputModuleProtocol & OutputModuleProtocol {
    
    let input: Input
    let output: Output
    
    let viewController: UIViewController
    
    init(input: Input, output: Output, viewController: UIViewController) {
        self.input = input
        self.output = output
        self.viewController = viewController
    }
}

// MARK: - Input

class InputModule<Input>: InputModuleProtocol {
    
    let input: Input
    let viewController: UIViewController
    
    init(input: Input, viewController: UIViewController) {
        self.input = input
        self.viewController = viewController
    }
}

// MARK: - Output

class OutputModule<Output>: OutputModuleProtocol {
    
    let output: Output
    let viewController: UIViewController
    
    init(output: Output, viewController: UIViewController) {
        self.output = output
        self.viewController = viewController
    }
}
