//
//  TimestampGeneratorTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 11/5/24.
//

import Foundation
import XCTest
@testable import DailyQuest

final class TimestampGeneratorTests: XCTestCase {
    func test_getTodayTimestamp_afterDayStarted() {
        let testingDate = Date(timeIntervalSince1970: 1715408247)
        let startOfDay = testingDate.startOfDay
        let timestamp = TimestampGenerator.generate(from: startOfDay)

        XCTAssertEqual(timestamp, "2024-05-11")
    }

    func test_getTodayTimestamp_beforeDayEnded() {
        let testingDate = Date(timeIntervalSince1970: 1712708247)
        let startOfDay = testingDate.endOfDay
        let timestamp = TimestampGenerator.generate(from: startOfDay)

        XCTAssertEqual(timestamp, "2024-04-10")
    }

    func test_getTodayTimestamp_inMiddleOfDay() {
        let testingDate = Date(timeIntervalSince1970: 1852708247)
        let timestamp = TimestampGenerator.generate(from: testingDate)

        XCTAssertEqual(timestamp, "2028-09-16")
    }
}

private extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}
