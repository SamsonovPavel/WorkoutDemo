//
//  AddWorkoutButton.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import SwiftUI

class AddWorkoutButton: BaseButton {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 24
        
        setTitle("Add workout", for: .normal)
        setTitleColor(.systemBlue, for: .normal)
    }
}

// MARK: - Preview

#if DEBUG
struct AddWorkoutButton_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutButton()
            .preview()
            .frame(height: 48)
            .padding(.horizontal, 20)
    }
}
#endif
