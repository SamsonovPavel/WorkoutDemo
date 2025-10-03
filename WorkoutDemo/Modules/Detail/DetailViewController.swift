//
//  DetailViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class DetailViewController: BaseViewController {
    
    private var workoutButtonPublisher: AnyPublisher<Void, Never> {
        workoutButton.publisher(for: .touchUpInside)
            .mapToVoid()
            .eraseToAnyPublisher()
    }
    
    private let startWorkoutSubject = PassthroughSubject<Void, Never>()
    private let viewModel: DetailViewModelProtocol
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
       
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
       
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
       
        return label
    }()
    
    private let workoutButton = WorkoutButton(style: .normal)
    
    init(_ model: DetailViewModelProtocol) {
        viewModel = model
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConsraints()
        bind()
    }

    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(durationLabel)
        view.addSubview(workoutButton)
        
        let fullDate = DateFormatter.fullDate.string(
            from: viewModel.currentModel.date
        )
        
        titleLabel.text = viewModel.currentModel.title
        durationLabel.text = viewModel.currentModel.duration
        dateLabel.text = fullDate
        
        view.backgroundColor = .white
    }
    
    private func setupConsraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(120)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
        }
        
        workoutButton.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(durationLabel.snp.bottom).offset(32)
            make.height.equalTo(48)
        }
    }

    private func bind() {
        viewModel.bind(
            DetailViewModel.Input(
                startWorkout: workoutButtonPublisher
                    .eraseToAnyPublisher()
            )
        )
    }
}

// MARK: - Preview

#if DEBUG
extension DetailViewController {
    
    convenience init() {
        self.init(
            DetailViewModel(
                model: DetailViewModel.Model(
                    title: "Тренировка в зале",
                    date: Date(),
                    duration: "10 мин"
                )
            )
        )
    }
}

struct DetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewController()
            .preview()
    }
}
#endif
