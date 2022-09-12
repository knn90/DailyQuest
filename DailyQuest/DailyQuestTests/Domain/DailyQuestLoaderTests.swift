//
//  DailyQuestLoaderTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 2022.09.11
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation
import XCTest
import DailyQuest

final class DailyQuestLoaderTests: XCTestCase {

    func test_init_doesNotSendRequestToStore() {
        let (_, store) = makeSUT(result: .failure(anyNSError()))

        XCTAssertTrue(store.dates.isEmpty)
    }

    func test_load_sendsRequestWithCorrectDate() async throws {
        let date = anyFixedDate()
        let (sut, store) = makeSUT(result: .success(anyLocalDailyQuest()))

        _ = try await sut.load(date: date)

        XCTAssertEqual(store.dates, [date])
    }

    func test_loadTwice_sendRequestToStoreTwice() async throws {
        let date1 = anyFixedDate()
        let date2 = date1.add(day: 1)
        let (sut, store) = makeSUT(result: .success(anyLocalDailyQuest()))

        _ = try await sut.load(date: date1)
        _ = try await sut.load(date: date2)

        XCTAssertEqual(store.dates, [date1, date2])
    }

    func test_load_throwsOnStoreError() async {
        let date = anyFixedDate()
        let expectedError = anyNSError()
        let (sut, _) = makeSUT(result: .failure(expectedError))

        do {
            _ = try await sut.load(date: date)
            XCTFail("Expected to throw error: \(expectedError)")
        } catch {
            XCTAssertEqual(expectedError, error as NSError?)
        }
    }

    func test_load_returnsFoundDailyQuestOnNonEmptyStore() async throws {
        let date = anyFixedDate()
        let dailyQuest = uniqueDailyQuest()

        let (sut, _) = makeSUT(result: .success(dailyQuest.local))

        let result = try await sut.load(date: date)

        XCTAssertEqual(result, dailyQuest.model)
    }

    func test_load_returnsNilOnEmptyStore() async throws {
        let date = anyFixedDate()

        let (sut, _) = makeSUT(result: .success(nil))

        let result = try await sut.load(date: date)

        XCTAssertNil(result)
    }

    private func makeSUT(result: Result<LocalDailyQuest?, Error>, file: StaticString = #file, line: UInt = #line) -> (DailyQuestLoader, StoreSpy) {
        let store = StoreSpy(result: result)
        let sut = DailyQuestLoader(store: store)

        trackForMemoryLeak(store, file: file, line: line)
        trackForMemoryLeak(sut, file: file, line: line)

        return (sut, store)
    }

    private class StoreSpy: DailyQuestStore {

        private(set) var dates: [Date] = []
        private let result: Result<LocalDailyQuest?, Error>

        init(result: Result<LocalDailyQuest?, Error>) {
            self.result = result
        }

        func load(date: Date) async throws -> LocalDailyQuest? {
            dates.append(date)
            return try result.get()
        }
    }
}

