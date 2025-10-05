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
    
    private var progressButtonPublisher: AnyPublisher<Void, Never> {
        progressButton.publisher(for: .touchUpInside)
            .mapToVoid()
            .eraseToAnyPublisher()
    }
    
    // Вызывается по событию завершения тренировки
    private let cancelWorkoutSubject = PassthroughSubject<Void, Never>()
    private let viewModel: ProgressViewModelProtocol
    
    private lazy var circleProgressView = CircleProgressView(
        timeInterval: TimeInterval(
            viewModel.currentModel.duration
        ) ?? 0,
    )
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.currentModel.title
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private let progressButton = WorkoutButton(style: .progress)
    
    private var isProgress: Bool = false {
        didSet {
            refreshProgressButton()
        }
    }
    
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
        view.addSubviews(
            titleLabel,
            circleProgressView,
            progressButton
        )
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.left.right.equalToSuperview().inset(20)
        }
        
        circleProgressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        progressButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(44)
            make.height.equalTo(48)
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
        
        progressButtonPublisher
            .receive(on: .mainQueue)
            .sink { [unowned self] in
                isProgress.toggle()
                
            }.store(in: &bindings)
        
        circleProgressView.completePublisher
            .receive(on: .mainQueue)
            .sink(receiveValue: cancelWorkoutSubject.send)
            .store(in: &bindings)
    }
    
    private func refreshProgressButton() {
        progressButton.setTitle(
            isProgress ? "Start" : "Stop",
            for: .normal
        )
        
        isProgress
        ? circleProgressView.stopTimer()
        : circleProgressView.startTimer()
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
                    duration: "60"
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
