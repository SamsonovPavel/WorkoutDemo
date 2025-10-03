//
//  WorkoutButton.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import SwiftUI

class WorkoutButton: BaseButton {
    
    enum StyleType {
        case add
        case normal
        
        var title: String {
            switch self {
            case .add: return "Add workout"
            case .normal: return "Start"
            }
        }
    }
    
    init(style: StyleType) {
        super.init(frame: .zero)
        setupView(style: style)
    }
    
    private func setupView(style: StyleType) {
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 24
        
        setTitle(style.title, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
    }
}

// MARK: - Preview

#if DEBUG
struct WorkoutButton_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutButton(style: .add)
            .preview()
            .frame(height: 48)
            .padding(.horizontal, 20)
    }
}
#endif
