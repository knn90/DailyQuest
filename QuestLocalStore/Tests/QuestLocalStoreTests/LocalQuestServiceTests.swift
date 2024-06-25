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
            let date = Date(timeIntervalSince1970: 92893423)
            _ = try sut.getQuest(date: date)
            XCTFail("Expect to throws error")
        } catch let receivedError {
            XCTAssertEqual(receivedError as NSError, stubError)
        }
    }

    func test_getTodayQuest_deliverExistingDailyQuestOnRetrieveSuccessWithSameDate() throws {
        let stubTasks = [uniqueTask(), uniqueTask(), completedTask()]

        let timestamp = Date(timeIntervalSince1970: 92893423)
        let stubQuest = uniqueQuest(timestamp: timestamp, tasks: stubTasks)
        let (sut, _) = makeSUT(stubResult: .success(stubQuest))

        let receivedQuest = try sut.getQuest(date: timestamp)

        XCTAssertEqual(receivedQuest, stubQuest)
    }

    func test_getTodayQuest_deliverExistingDailyQuestOnRetrieveSuccessWithDifferentDate() throws {
        let stubTask = completedTask()
        let timestamp = Date(timeIntervalSince1970: 92893423)
        let stubQuest = uniqueQuest(timestamp: timestamp, tasks: [stubTask])
        let (sut, _) = makeSUT(stubResult: .success(stubQuest))


        let anotherDateTimestamp = Date(timeIntervalSince1970: 563483739)
        let receivedQuest = try sut.getQuest(date: anotherDateTimestamp)

        XCTAssertEqual(receivedQuest.tasks.first?.id, stubTask.id)
        XCTAssertEqual(receivedQuest.tasks.first?.title, stubTask.title)
        XCTAssertEqual(receivedQuest.tasks.first?.description, stubTask.description)
        XCTAssertEqual(receivedQuest.tasks.first?.isCompleted, false)
    }

    func test_getTodayQuest_deliverNewDailyQuestWithEmptyTaskWhenRetrieveReturnsNil() throws {
        let (sut, questStore) = makeSUT(stubResult: .success(nil))
        
        let date = Date(timeIntervalSince1970: 92893423)
        let receivedQuest = try sut.getQuest(date: date)

        XCTAssertEqual(questStore.message, [.retrieve, .insert])
        XCTAssertFalse(receivedQuest.id.isEmpty)
        XCTAssertEqual(receivedQuest.tasks, [])
    }

//    func test_getTodayQuest_sendsUpdateMessageToQuestStore_whenTheQuestIsNotForToday() throws {
//        let stubTasks = [uniqueTask(), uniqueTask(), uniqueTask()]
//        let stubQuest = uniqueQuest(tasks: stubTasks)
//        let (sut, questStore) = makeSUT(stubResult: .success(stubQuest))
//
//        let receivedQuest = try sut.getTodayQuest()
//
//        XCTAssertEqual(questStore.message, [.retrieve, .update(stubQuest)])
//    }

//    func test_updateQuest_throwsErrorWhenStoreUpdatingFailed() {
//
//        let stubError = anyNSError()
//        let (sut, _) = makeSUT(stubResult: .failure(stubError))
//
//        do {
//            try sut.updateQuest(uniqueQuest())
//            XCTFail("Expect to throws error")
//        } catch {
//            XCTAssertEqual(error as NSError, stubError)
//        }
//    }

    func test_addTask_sendsAddTaskMessageToQuestStore() throws {
        let title = "any title"
        let (sut, questStore) = makeSUT()

        try sut.addTask(title: title)

        XCTAssertEqual(questStore.message, [.addTask(title)])
    }

    func test_addTasks_throwsErrorWhenStoreAddingTaskFailed() {
        let stubError = anyNSError()
        let (sut, _) = makeSUT(stubResult: .failure(stubError))

        do {
            try sut.addTask(title: "any title")
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
        case addTask(String)
    }

    init(stubResult: Result<DailyQuest?, Error>) {
        self.stubResult = stubResult
    }

    func retrieve() throws -> DailyQuest? {
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

    func addTask(_ task: DailyTask) throws {
        message.append(.addTask(task.title))
        _ = try stubResult.get()
    }
}
