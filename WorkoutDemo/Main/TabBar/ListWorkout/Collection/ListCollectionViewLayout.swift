//
//  ListCollectionViewLayout.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import UIKit

class ListCollectionViewLayout: UICollectionViewCompositionalLayout {
    
    init() {
        super.init { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) in
            if let sectionType = ListCollectionDataSource.SectionType(rawValue: sectionIndex) {
                switch sectionType {
                case .workouts: return Self.workoutLayoutSection()
                }
            }
            
            return nil
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private static func workoutLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(58)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(58)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let sectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(38)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.interGroupSpacing = 8
        section.contentInsets.top = 24
        section.contentInsets.bottom = 24
        
        return section
    }
}
