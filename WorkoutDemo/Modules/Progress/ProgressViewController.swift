//
//  ProgressViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class ProgressViewController: BaseViewController {
    
    // Вызывается по событию завершения тренировки
    private let cancelWorkoutSubject = PassthroughSubject<Void, Never>()
    private let viewModel: ProgressViewModelProtocol
    
    private let circleProgressView = CircleProgressView()
    
    init(_ model: ProgressViewModelProtocol) {
        viewModel = model
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind()
    }
    
    private func setupViews() {
        view.addSubview(circleProgressView)
        
        circleProgressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.backgroundColor = .white
    }

    private func bind() {
        viewModel.bind(
            ProgressViewModel.Input(
                cancelWorkout: cancelWorkoutSubject
                    .eraseToAnyPublisher()
            )
        )
    }
}

// MARK: - Preview

#if DEBUG
extension ProgressViewController {
    
    convenience init() {
        self.init(
            ProgressViewModel(
                model: ProgressViewModel.Model(
                    title: "Тренировка в зале",
                    date: Date(),
                    duration: "10 мин"
                )
            )
        )
    }
}

struct ProgressViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewController()
            .preview()
    }
}
#endif
