//
//  XCTestCase+TrackForMemoryLeaks.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 8/5/24.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance is not dealocated. Potential memory leak", file: file, line: line)
        }
    }
}
