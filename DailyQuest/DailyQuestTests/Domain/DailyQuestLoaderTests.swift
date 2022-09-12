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


protocol DailyQuestStore {
    func load(date: Date) async throws -> LocalDailyQuest
}

final class DailyQuestLoader {
    private let store: DailyQuestStore

    init(store: DailyQuestStore) {
        self.store = store
    }

    func load(date: Date) async throws -> DailyQuest {
        let local = try await store.load(date: date)

        return local.toDomain()
    }
}

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

    func test_load_returnsDailyQuestOnStoreSuccess() async throws {
        let date = anyFixedDate()
        let local = LocalDailyQuest(id: UUID(), createAt: date, doneAt: nil, quests: [LocalQuest(id: UUID(), title: "title", isDone: false)])

        let (sut, _) = makeSUT(result: .success(local))

        let result = try await sut.load(date: date)

        XCTAssertEqual(result, local.toDomain())
    }

    private func makeSUT(result: Result<LocalDailyQuest, Error>, file: StaticString = #file, line: UInt = #line) -> (DailyQuestLoader, StoreSpy) {
        let store = StoreSpy(result: result)
        let sut = DailyQuestLoader(store: store)

        trackForMemoryLeak(store, file: file, line: line)
        trackForMemoryLeak(sut, file: file, line: line)

        return (sut, store)
    }

    private class StoreSpy: DailyQuestStore {

        private(set) var dates: [Date] = []
        private let result: Result<LocalDailyQuest, Error>

        init(result: Result<LocalDailyQuest, Error>) {
            self.result = result
        }

        func load(date: Date) async throws -> LocalDailyQuest {
            dates.append(date)
            return try result.get()
        }
    }
}

func anyNSError() -> NSError {
    NSError(domain: "any", code: -1)
}

func anyDailyQuest() -> DailyQuest {
    DailyQuest(id: UUID(), createAt: anyFixedDate(), doneAt: anyFixedDate(), quests: [])
}

func anyLocalDailyQuest() -> LocalDailyQuest {
    LocalDailyQuest(id: UUID(), createAt: anyFixedDate(), doneAt: nil, quests: [])
}

func anyFixedDate() -> Date {
    Date(timeIntervalSince1970: 3453463543)
}

extension Date {
    func add(day: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: day, to: self)!
    }
}
