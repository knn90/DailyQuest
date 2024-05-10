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

    func XCTAssertThrowsErrorAsync<T, R>(
        _ expression: @autoclosure () async throws -> T,
        _ errorThrown: @autoclosure () -> R,
        _ message: @autoclosure () -> String = "This method should fail",
        file: StaticString = #filePath,
        line: UInt = #line
    ) async where R: Equatable, R: Error  {
        do {
            let _ = try await expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            XCTAssertEqual(error as? R, errorThrown())
        }
    }
}
