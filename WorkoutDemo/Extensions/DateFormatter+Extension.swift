//
//  DateFormatter+Extension.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Foundation

extension DateFormatter {

    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = .current
        formatter.timeZone = .current
        
        return formatter
    }()
    
    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeZone = .current
        
        return formatter
    }()
}
