//
//  LocalQuestServiceTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 10/5/24.
//

import Foundation
import XCTest
import QuestServices

@testable import QuestLocalStore

final class LocalQuestServiceTests: XCTestCase {
    func test_getTodayQuest_throwsErrorOnRetrieveFailed() throws {
        let stubError = anyNSError()
        let (sut, _) = makeSUT(stubResult: .failure(stubError))

        do {
            _ = try sut.getTodayQuest()
            XCTFail("Expect to throws error")
        } catch let receivedError {
            XCTAssertEqual(receivedError as NSError, stubError)
        }
    }

    func test_getTodayQuest_deliverDailyQuestArrayOnRetrieveSuccess() throws {
        let stubTasks = [uniqueTask(), uniqueTask(), uniqueTask()]
        let stubQuest = uniqueQuest(tasks: stubTasks)
        let (sut, _) = makeSUT(stubResult: .success(stubQuest))

        let receivedQuest = try sut.getTodayQuest()

        XCTAssertEqual(receivedQuest, stubQuest)
    }

    func test_getTodayQuest_deliverNewDailyQuestWhenRetrieveReturnsNil() throws {
        let (sut, questStore) = makeSUT(stubResult: .success(nil))
        
        let receivedQuest = try sut.getTodayQuest()

        XCTAssertEqual(questStore.message, [.retrieve, .insert])
        XCTAssertFalse(receivedQuest.id.isEmpty)
        XCTAssertFalse(receivedQuest.timestamp.isEmpty)
        XCTAssertEqual(receivedQuest.tasks, [])
    }

    func test_updateQuest_sendsUpdateMessageToQuestStore() throws {
        let quest = uniqueQuest()
        let (sut, questStore) = makeSUT()

        try sut.updateQuest(quest)

        XCTAssertEqual(questStore.message, [.update(quest)])
    }

    func test_updateQuest_throwsErrorWhenStoreUpdatingFailed() {
        
        let stubError = anyNSError()
        let (sut, _) = makeSUT(stubResult: .failure(stubError))

        do {
            try sut.updateQuest(uniqueQuest())
            XCTFail("Expect to throws error")
        } catch {
            XCTAssertEqual(error as NSError, stubError)
        }
    }

    private func makeSUT(
        stubResult: Result<DailyQuest?, Error> = .success(nil),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (LocalQuestService, StubQuestStore) {
        let questStore = StubQuestStore(stubResult: stubResult)
        let sut = LocalQuestService(store: questStore)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(questStore, file: file, line: line)

        return (sut, questStore)
    }
}

private class StubQuestStore: QuestStore {
    private(set) var stubResult: Result<DailyQuest?, Error>
    private(set) var message: [Message] = []

    enum Message: Equatable {
        case retrieve
        case insert
        case update(DailyQuest)
    }

    init(stubResult: Result<DailyQuest?, Error>) {
        self.stubResult = stubResult
    }

    func retrieve(for date: String) throws -> DailyQuest? {
        message.append(.retrieve)
        return try stubResult.get()
    }

    func insert(quest: DailyQuest) throws {
        message.append(.insert)

    }

    func update(quest: DailyQuest) throws {
        message.append(.update(quest))
        _ = try stubResult.get()
    }
}