//
//  TabBarViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine

class TabBarViewController: UITabBarController {
    
    private var bindings = Set<AnyCancellable>()
    
    enum TabItemType: Int, CaseIterable {
        case main
        case workouts
        case aboutApp

        var icon: UIImage? {
            switch self {
            case .main: UIImage(systemName: "figure.highintensity.intervaltraining.circle.fill")
            case .workouts: UIImage(systemName: "list.clipboard")
            case .aboutApp: UIImage(systemName: "info")
            }
        }
        
        var title: String {
            switch self {
            case .main: "Home"
            case .workouts: "Workouts"
            case .aboutApp: "About"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .systemBlue
    }
    
    func didSelectTab(_ itemType: TabItemType) {
        selectedIndex = itemType.rawValue
    }
    
    func updateBadgeValue(_ itemType: TabItemType, value: Int?) {}
    func updateProfileIcon() {}
}

typealias TabItemType = TabBarViewController.TabItemType
