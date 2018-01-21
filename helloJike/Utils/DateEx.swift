//
//  DateEx.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/21.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation

private let calendar = Calendar(identifier: .iso8601)


private let hourMinuteFormat = DateFormatter(withFormat: "HH:mm", locale: "en_US_POSIX")
private let monthDayFormat = DateFormatter(withFormat: "MM:dd", locale: "en_US_POSIX")
private let yearMonthDayFormat = DateFormatter(withFormat: "yyyy:MM:dd", locale: "en_US_POSIX")

// MARK: - Helper
extension Date {
    var isToday:Bool {
        let dateComponents = calendar.dateComponents(in: .current, from: self)
        let nowDateComponents = calendar.dateComponents(in: .current, from: Date())
        
        return nowDateComponents.day == dateComponents.day
            && nowDateComponents.month == dateComponents.month
            && nowDateComponents.year == dateComponents.year
    }
    
    var isThisYear:Bool {
        let dateComponents = calendar.dateComponents(in: .current, from: self)
        let nowDateComponents = calendar.dateComponents(in: .current, from: Date())
        return nowDateComponents.year == dateComponents.year
    }
}

// MARK: - Format
extension Date {
    
}

// MARK: - Date string
extension Date {
    var messageDateString : String {
        if isToday {
            return hourMinuteFormat.string(from: self)
        } else if isThisYear {
            return monthDayFormat.string(from: self)
        } else {
            return yearMonthDayFormat.string(from: self)
        }
    }
}
