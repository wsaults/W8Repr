//
//  RepEntry.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import Foundation
import SwiftData

enum RepType: String, Codable, CaseIterable {
    case pushups
    case squats
    case pullups
    case dips
    case situps
    case burpees
    case lunges
    case planks
    case jumpingJacks
    case mountainClimbers
    case highKnees
}

@Model
final class RepEntry {
    var count: Int = 0
    var type: RepType = RepType.pushups
    var date: Date = Date.now
    
    init(count: Int, type: RepType, date: Date = Date.now) {
        self.count = count
        self.type = type
        self.date = date
    }
    
    static var shortSampleData: [RepEntry] {
        let calendar = Calendar.current
        let today = Date.now
        
        func dateTime(daysAgo: Int) -> Date {
            let dateWithDays = calendar.date(byAdding: .day, value: -daysAgo, to: today)!
            let dateWithHours = calendar.date(byAdding: .hour, value: Int.random(in: 6...10), to: dateWithDays)!
            return calendar.date(byAdding: .minute, value: Int.random(in: 0...59), to: dateWithHours)!
        }
        
        return [
            RepEntry(count: 10, type: .pushups, date: dateTime(daysAgo: 0)),
            RepEntry(count: 20, type: .squats, date: dateTime(daysAgo: 1)),
            RepEntry(count: 30, type: .pullups, date: dateTime(daysAgo: 2)),
            RepEntry(count: 40, type: .dips, date: dateTime(daysAgo: 3))
        ]
    }
}
