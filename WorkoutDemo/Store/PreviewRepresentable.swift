//
//  PreviewRepresentable.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import SwiftUI

protocol PreviewRepresentable {
    
    associatedtype PreviewType
    func preview() -> PreviewType
}
