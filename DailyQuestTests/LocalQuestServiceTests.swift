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
    func test_fetch_deliverDailyTaskArrayOnFetchSuccess() async throws {
        let stubTasks = [uniqueTask(), uniqueTask(), uniqueTask()]
        let sut = makeSUT(stubResult: .success(stubTasks))

        let receivedTasks = try await sut.getDailyQuest()

        XCTAssertEqual(receivedTasks, stubTasks)
    }

    func test_fetch_throwsErrorOnFetchFailed() async throws {
        let stubError = anyNSError()
        let sut = makeSUT(stubResult: .failure(stubError))

        do {
            _ = try await sut.getDailyQuest()
        } catch let receivedError {
            XCTAssertEqual(receivedError as NSError, stubError)
        }
    }

    private func makeSUT(
        stubResult: Result<[DailyTask], Error> = .success([]),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> LocalQuestService {
        let repository = StubQuestRepository(stubResult: stubResult)
        let sut = LocalQuestService(repository: repository)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(repository, file: file, line: line)

        return sut
    }
}

private class StubQuestRepository: QuestRepository {
    private(set) var stubResult: Result<[DailyTask], Error>

    init(stubResult: Result<[DailyTask], Error>) {
        self.stubResult = stubResult
    }

    func fetch() async throws -> [DailyTask] {
        return try stubResult.get()
    }
}
