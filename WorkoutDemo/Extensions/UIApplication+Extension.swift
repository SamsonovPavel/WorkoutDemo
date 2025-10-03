//
//  UIApplication+Extension.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import UIKit

extension UIApplication {

    var scene: UIWindowScene? {
        connectedScenes
            .first(where: { $0 is UIWindowScene })
            .flatMap { $0 as? UIWindowScene }
    }
    
    var keyWindow: UIWindow? {
        guard let scene = scene else { return nil }
        
        return scene
            .windows
            .first(where: \.isKeyWindow)
    }
    
    var safeAreaInsets: UIEdgeInsets {
        guard let keyWindow = keyWindow else {
            return .zero
        }
        
        return keyWindow.safeAreaInsets
    }
}
