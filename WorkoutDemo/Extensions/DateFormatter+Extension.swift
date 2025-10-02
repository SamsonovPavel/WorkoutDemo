//
//  DateFormatter+Extension.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import Foundation

extension DateFormatter {

    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = .current
        formatter.timeZone = .current
        
        return formatter
    }()
}
