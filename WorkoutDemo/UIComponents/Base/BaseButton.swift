//
//  BaseButton.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import UIKit

class BaseButton: UIButton {
    
    private var contentOpacity: CGFloat {
        if state == .normal {
            return 1
        } else {
            return 0.5
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            animateOpacity()
        }
    }
    
    var buttonIcon: UIImage? {
        didSet {
            updateButtonImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearanceViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        setupAppearanceViews()
    }

    func setupAppearanceViews() {}

    private func animateOpacity() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = self.contentOpacity
        }
    }
    
    private func updateButtonImage() {
        setImage(buttonIcon, for: .normal)
        setImage(buttonIcon, for: .highlighted)
    }
}
