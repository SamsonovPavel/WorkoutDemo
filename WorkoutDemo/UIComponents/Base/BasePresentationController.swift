//
//  BasePresentationController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import UIKit

class BasePresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView,
              let presentedView = presentedView else {
            return super.frameOfPresentedViewInContainerView
        }

        let maxHeight = containerView.frame.height - containerView.safeAreaTop - containerView.safeAreaBottom
        
        let fittingSize = CGSize(
            width: containerView.bounds.width,
            height: UIView.layoutFittingCompressedSize.height
        )
        
        let presentedViewSize = presentedView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        let presentedViewHeight = presentedViewSize.height

        let totalHeight = presentedViewHeight == .zero ? maxHeight : presentedViewHeight
        let contentHeight = min(totalHeight, maxHeight)
        
        let totalSize = CGSize(width: containerView.frame.width, height: contentHeight)
        let totalOrigin = CGPoint(x: .zero, y: containerView.frame.maxY - totalSize.height)
        
        return CGRect(origin: totalOrigin, size: totalSize)
    }
}
