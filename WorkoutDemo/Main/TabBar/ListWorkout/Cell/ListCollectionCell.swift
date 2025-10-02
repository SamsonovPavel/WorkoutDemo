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
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupViews() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(accessoryImageView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(durationLabel)
        
        cellImageView.image = UIImage(systemName: "figure.run")
        cellImageView.contentMode = .scaleAspectFit
        
        accessoryImageView.image = UIImage(systemName: "chevron.right")
        accessoryImageView.contentMode = .scaleAspectFit
        
        cellImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.size.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(cellImageView.snp.right).offset(8)
            make.right.top.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }
        
        durationLabel.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right).offset(8)
        }
        
        accessoryImageView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(cellImageView)
        }
        
        dateLabel.snp.contentHuggingHorizontalPriority = UILayoutPriority.defaultHigh.rawValue
    }
    
    func configure(_ model: Model) {
        let fullDate = DateFormatter.fullDate.string(
            from: model.date
        )

        titleLabel.text = model.title
        durationLabel.text = model.duration
        dateLabel.text = fullDate
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
        duration: "60 мин"
    )
}

struct ListCollectionCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCollectionCell(.model)
            .preview()
            .frame(height: 52)
            .padding()
    }
}
#endif
