//
//  TabBarViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine
import SwiftUI

class TabBarViewController: UITabBarController {
    
    private var bindings = Set<AnyCancellable>()
    
    enum TabItemType: Int, CaseIterable {
        case home
        case listWorkout
        case aboutApp

        var icon: UIImage? {
            switch self {
            case .home: UIImage(systemName: "figure.run")
            case .listWorkout: UIImage(systemName: "list.bullet.rectangle.portrait")
            case .aboutApp: UIImage(systemName: "info")
            }
        }
        
        var title: String {
            switch self {
            case .home: "Главная"
            case .listWorkout: "Список"
            case .aboutApp: "О приложении"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .systemGray
    }
    
    func didSelectTab(_ itemType: TabItemType) {
        selectedIndex = itemType.rawValue
    }
    
    func updateBadgeValue(_ itemType: TabItemType, value: Int) {
        guard let items = tabBar.items else { return }

        items[itemType.rawValue].badgeValue = String(value)
    }
}

typealias TabItemType = TabBarViewController.TabItemType
