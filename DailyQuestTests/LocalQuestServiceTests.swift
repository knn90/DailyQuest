//
//  LocalQuestServiceTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 10/5/24.
//

import Foundation
import XCTest
@testable import DailyQuest

final class LocalQuestServiceTests: XCTestCase {
    func test_getTodayQuest_throwsErrorOnFetchFailed() async throws {
        let stubError = anyNSError()
        let sut = makeSUT(stubResult: .failure(stubError))

        do {
            _ = try await sut.getTodayQuest()
        } catch let receivedError {
            XCTAssertEqual(receivedError as NSError, stubError)
        }
    }

    func test_getTodayQuest_deliverDailyTaskArrayOnFetchSuccess() async throws {
        let stubTasks = [uniqueTask(), uniqueTask(), uniqueTask()]
        let stubQuest = uniqueQuest(tasks: stubTasks)
        let sut = makeSUT(stubResult: .success(stubQuest))

        let receivedQuest = try await sut.getTodayQuest()

        XCTAssertEqual(receivedQuest, stubQuest)
    }

    private func makeSUT(
        stubResult: Result<DailyQuest, Error> = .success(emptyQuest()),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> LocalQuestService {
        let questStore = StubQuestStore(stubResult: stubResult)
        let sut = LocalQuestService(store: questStore)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(questStore, file: file, line: line)

        return sut
    }
}

private class StubQuestStore: QuestStore {
    private(set) var stubResult: Result<DailyQuest, Error>

    init(stubResult: Result<DailyQuest, Error>) {
        self.stubResult = stubResult
    }

    func retrieve(for date: String) async throws -> DailyQuest? {
        return try stubResult.get()
    }

    func insert(quest: DailyQuest) throws {

    }

    func update(quest: DailyQuest) async throws {

    }
}
