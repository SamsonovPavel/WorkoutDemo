//
//  ListCollectionCell.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import SwiftUI
import SnapKit

class ListCollectionCell: UICollectionViewCell {
    
    private let cellImageView = UIImageView()
    private let accessoryImageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    private let separatorView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupViews() {
        contentView.addSubviews(
            cellImageView,
            accessoryImageView,
            titleLabel,
            dateLabel,
            durationLabel,
            separatorView
        )
        
        cellImageView.image = UIImage(systemName: "figure.run")
        cellImageView.contentMode = .scaleAspectFit
        
        accessoryImageView.image = UIImage(systemName: "chevron.right")
        accessoryImageView.contentMode = .scaleAspectFit
        
        separatorView.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        
        cellImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview().offset(-4)
            make.size.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(cellImageView.snp.right).offset(8)
            make.right.top.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(dateLabel)
            make.left.equalTo(dateLabel.snp.right).offset(8)
        }
        
        accessoryImageView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(cellImageView)
        }
        
        separatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        dateLabel.snp.contentHuggingHorizontalPriority = UILayoutPriority.defaultHigh.rawValue
    }
    
    func configure(_ model: Model) {
        let fullDate = DateFormatter.shortDate.string(
            from: model.date
        )

        titleLabel.text = model.title
        durationLabel.text = "Длительность \(model.duration) мин."
        dateLabel.text = "\(fullDate),"
    }
}

extension ListCollectionCell {
    
    struct Model: Hashable {
        
        let title: String
        let date: Date
        let duration: String
    }
}

// MARK: - Preview

#if DEBUG
extension ListCollectionCell {
    
    convenience init(_ model: Model) {
        self.init()
        configure(model)
    }
}

extension ListCollectionCell.Model {
    
    static let model = ListCollectionCell.Model(
        title: "Тренировка в зале",
        date: Date(),
        duration: "60"
    )
}

struct ListCollectionCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCollectionCell(.model)
            .preview()
            .frame(height: 58)
            .padding()
    }
}
#endif
