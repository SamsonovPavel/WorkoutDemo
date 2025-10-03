//
//  UserDefaults+Stored.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Foundation

extension UserDefaults {
    
    @UserDefaultsStored(key: "loginName", defaultValue: "")
    static var loginName: String
}
