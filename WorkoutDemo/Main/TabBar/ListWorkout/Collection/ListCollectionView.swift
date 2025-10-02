//
//  ListCollectionView.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import UIKit
import Combine

class ListCollectionView: UICollectionView {
    
    typealias RowType = ListCollectionDataSource.RowType
    
    private let didSelectRowSubject = PassthroughSubject<RowType, Never>()
    private let viewDidScrollSubject = PassthroughSubject<Bool, Never>()
    
    var didSelectRow: AnyPublisher<RowType, Never> {
        didSelectRowSubject.eraseToAnyPublisher()
    }
    
    var viewDidScroll: AnyPublisher<Bool, Never> {
        viewDidScrollSubject.eraseToAnyPublisher()
    }
    
    init() {
        let layout = ListCollectionViewLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func configure() {
        backgroundColor = .white
        
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = false
        
        delegate = self
    }
}

extension ListCollectionView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = dataSource as? ListCollectionDataSource else { return }

        if let rowType = dataSource.itemIdentifier(for: indexPath) {
            didSelectRowSubject.send(rowType)
        }
    }
}
