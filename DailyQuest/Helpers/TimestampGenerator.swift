//
//  Helpers.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 11/5/24.
//

import Foundation

class TimestampGenerator {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private init() {}

    static func generate(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    static func generateTodayTimestamp() -> String {
        return dateFormatter.string(from: Date())
    }
}
