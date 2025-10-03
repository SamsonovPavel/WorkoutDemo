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
        label.text = style.title
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = keyboardType
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    private let style: StyleType
    private let keyboardType: UIKeyboardType
    
    var textString: String? {
        titleTextField.text
    }
    
    enum StyleType {
        case name
        case nameWorkout
        case duration
        
        var title: String {
            switch self {
            case .name: "Введите Ваше имя"
            case .nameWorkout: "Название тренировки"
            case .duration: "Длительность (до 100 мин)"
            }
        }
    }
    
    init(style: StyleType, keyboardType: UIKeyboardType) {
        self.style = style
        self.keyboardType = keyboardType
        super.init(frame: .zero)
        
        setupViews()
    }
    
    convenience init(style: StyleType) {
        self.init(
            style: style,
            keyboardType: .emailAddress
        )
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
        
        titleTextField.layer.cornerRadius = 8
        titleTextField.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.5).cgColor
        titleTextField.layer.borderWidth = 1
    }
    
    func reset() {
        titleTextField.text = nil
    }
}

// MARK: - Preview

#if DEBUG
extension TitleTextFieldView {
    
    convenience init() {
        self.init(style: .nameWorkout)
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
