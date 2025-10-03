//
//  NewWorkoutView.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class NewWorkoutView: UIView {
    
    private var addWorkoutButtonPublisher: AnyPublisher<Model, Never> {
        addWorkoutButton.publisher(for: .touchUpInside)
            .map { _ in
                Model(
                    title: self.titleTextFieldView.textString ?? "",
                    duration: self.durationTextFieldView.textString ?? ""
                )
            }
            .eraseToAnyPublisher()
    }
    
    var addWorkoutPublisher: AnyPublisher<Model, Never> {
        addWorkoutButtonPublisher.eraseToAnyPublisher()
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleTextFieldView,
                durationTextFieldView
            ]
        )
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var titleTextFieldView = TitleTextFieldView(title: "Название тренировки")
    private lazy var durationTextFieldView = TitleTextFieldView(title: "Длительность (мин)")
    
    private lazy var addWorkoutButton = WorkoutButton(style: .add)
    private var bindings = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupViews() {
        addSubview(stackView)
        addSubview(addWorkoutButton)
        
        stackView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        titleTextFieldView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        durationTextFieldView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        addWorkoutButton.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(32)
            make.height.equalTo(48)
        }
    }
    
    private func bind() {
        addWorkoutPublisher
            .receive(on: .mainQueue)
            .sink { [unowned self] _ in
                endEditing(true)
                
            }.store(in: &bindings)
    }
}

extension NewWorkoutView {
    
    struct Model {
        
        let title: String
        let duration: String
    }
}

// MARK: - Preview

#if DEBUG
struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView()
            .preview()
            .frame(height: 220)
            .padding(.horizontal, 20)
    }
}
#endif
