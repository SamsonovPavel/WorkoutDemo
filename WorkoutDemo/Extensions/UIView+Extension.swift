//
//  UIView+Extension.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import UIKit

extension UIView {
    
    @discardableResult
    func addSubviews(_ views: UIView...) -> UIView {
        addSubviews(views)
    }

    @discardableResult
    func addSubviews(_ views: [UIView]) -> UIView {
        views.forEach(addSubview)
        return self
    }
}
