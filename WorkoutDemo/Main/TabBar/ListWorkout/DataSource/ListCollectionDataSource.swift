//
//  ListCollectionDataSource.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import UIKit

class ListCollectionDataSource: UICollectionViewDiffableDataSource<ListCollectionDataSource.SectionType, ListCollectionDataSource.RowType> {
    
    typealias ListCellModel = ListCollectionCell.Model
    
    typealias SeparatorHeaderRegistration = UICollectionView.SupplementaryRegistration<ListTitleHeaderView>
    typealias CommonCellRegistration = UICollectionView.CellRegistration<ListCollectionCell, ListCellModel>
 
    enum SectionType: Int, CaseIterable {
        case workouts
    }

    enum RowType: Hashable {
        case cell(ListCellModel)
    }
    
    private var currentSnapshot = NSDiffableDataSourceSnapshot<SectionType, RowType>()
    
    init(_ collectionView: UICollectionView) {
        let commonCellRegistration = CommonCellRegistration { cell, _, model in
            cell.configure(model)
        }
        
        super.init(collectionView: collectionView) { collectionView, indexPath, rowType in
            switch rowType {
            case .cell(let model):
                return collectionView.dequeueConfiguredReusableCell(
                    using: commonCellRegistration,
                    for: indexPath,
                    item: model
                )
            }
        }
        
        configure()
    }
    
    private func configure() {
        currentSnapshot.appendSections(SectionType.allCases)

        let headerRegistration = SeparatorHeaderRegistration(elementKind: UICollectionView.elementKindSectionHeader) { sectionFooterView, _, indexPath in }
        
        supplementaryViewProvider = { collectionView, elementKind, indexPath in
            if elementKind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration,
                    for: indexPath
                )   
            }
            
            return nil
        }
    }
    
    func reloadData() {
        if currentSnapshot.numberOfItems > 0 {
            currentSnapshot.deleteAllItems()
            currentSnapshot.appendSections(SectionType.allCases)
        }

        Task(priority: .medium) {
            do {
                let items = try getAllWorkouts()
                currentSnapshot.appendItems(items, toSection: .workouts)
                
                applySnapshot()
                
            } catch {
                
                print("Error fetching workouts: \(error)")
            }
        }
    }
}

extension ListCollectionDataSource {
    
    private func getAllWorkouts() throws -> [RowType] {
        do {
            let result = try CoreDataStack.shared.fetchAllWorkouts()
            
            return result.compactMap { workout in
                guard let title = workout.title,
                      let date = workout.date,
                      let duration = workout.duration else {
                    return nil
                }
                
                let model = ListCellModel(
                    title: title,
                    date: date,
                    duration: duration
                )
                
                return .cell(model)
            }
            
        } catch {
            
            throw CoreDataStack.CoreDataError.unknown(error)
        }
    }

    private func applySnapshot(animating: Bool = false) {
        apply(currentSnapshot, animatingDifferences: animating)
    }
}
