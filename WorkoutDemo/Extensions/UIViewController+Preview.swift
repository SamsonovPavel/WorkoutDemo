//
//  UIViewController+Preview.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import SwiftUI

extension UIViewController: PreviewRepresentable {
    
    func preview() -> some View {
        ViewPreview(self)
    }
}

extension UIViewController {
    
    struct ViewPreview<T: UIViewController>: UIViewControllerRepresentable {
        
        private let viewController: T
        
        init(_ viewController: T) {
            self.viewController = viewController
        }
        
        func makeUIViewController(context: Context) -> T {
            viewController
        }

        func updateUIViewController(_ uiViewController: T, context: Context) {}
    }
}
