//
//  UIView+SafeArea.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import UIKit

extension UIView {

    var safeAreaTop: CGFloat {
        UIApplication.shared.safeAreaInsets.top
    }
    
    var safeAreaBottom: CGFloat {
        UIApplication.shared.safeAreaInsets.bottom
    }
}
