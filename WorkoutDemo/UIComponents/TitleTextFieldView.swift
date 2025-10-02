//
//  TitleTextFieldView.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import SwiftUI
import SnapKit

class TitleTextFieldView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    private let title: String
    
    var textString: String? {
        titleTextField.text
    }
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(titleTextField)
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        titleTextField.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.5).cgColor
        titleTextField.layer.borderWidth = 1
    }
}

// MARK: - Preview

#if DEBUG
extension TitleTextFieldView {
    
    convenience init() {
        self.init(title: "Название тренировки")
    }
}

struct TitleTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TitleTextFieldView()
            .preview()
            .frame(height: 64)
            .padding(.horizontal, 20)
    }
}
#endif
