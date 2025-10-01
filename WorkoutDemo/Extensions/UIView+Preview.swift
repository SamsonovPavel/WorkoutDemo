//
//  UIView+Preview.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import SwiftUI

extension UIView: PreviewRepresentable {
    
    func preview() -> some View {
        ViewPreview(self)
    }
}

extension UIView {
    
    struct ViewPreview<T: UIView>: UIViewRepresentable {
        
        private let view: T
        
        init(_ view: T) {
            self.view = view
        }
        
        func makeUIView(context: Context) -> T {
            view
        }

        func updateUIView(_ uiView: T, context: Context) {}
    }
}
