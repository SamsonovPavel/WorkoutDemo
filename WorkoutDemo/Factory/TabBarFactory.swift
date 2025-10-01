//
//  TabBarFactory.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit

struct TabBarFactory {
    
    func createTabBarItem(tabItemType: TabItemType) -> UITabBarItem {
        UITabBarItem(
            title: tabItemType.title,
            image: tabItemType.icon,
            selectedImage: tabItemType.icon
        )
    }
}
