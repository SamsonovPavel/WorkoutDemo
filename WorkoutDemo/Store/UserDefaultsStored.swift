//
//  UserDefaultsStored.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Foundation

@propertyWrapper
struct UserDefaultsStored<T> {
    
    private let key: String
    private let defaultValue: T
    private let defaults: UserDefaults
    
    init(
        key: String,
        defaultValue: T,
        defaults: UserDefaults = .standard
    ) {
        self.key = key
        self.defaultValue = defaultValue
        self.defaults = defaults
    }

    var wrappedValue: T {
        get {
            if let value = defaults.value(forKey: key) as? T {
                return value
                
            } else {
                
                return defaultValue
            }
        }
        
        set {
            defaults.set(newValue, forKey: key)
        }
    }
}
