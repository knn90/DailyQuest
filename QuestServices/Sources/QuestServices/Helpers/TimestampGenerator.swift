//
//  Helpers.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 11/5/24.
//

import Foundation

public final class TimestampGenerator {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private init() {}

    public static func generate(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    public static func generateTodayTimestamp() -> String {
        return dateFormatter.string(from: Date())
    }
}
