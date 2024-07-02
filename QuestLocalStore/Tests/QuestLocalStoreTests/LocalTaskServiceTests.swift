//
//  LocalTaskServiceTests.swift
//
//
//  Created by Khoi Nguyen on 2/7/24.
//

import Foundation
import XCTest
import QuestServices

@testable import QuestLocalStore

final class LocalTaskServiceTests: XCTestCase {
    func test_updateTask_sendsRequestToStore() throws {
        let task = uniqueTask()
        let (sut, store) = makeSUT(stubResult: .success(()))

        try sut.updateTask(task)

        XCTAssertEqual(store.messages, [.update(task)])
    }

    func test_updateTask_throwsErrorWhenStoreUpdatesFailed() {
        let stubError = anyNSError()
        let (sut, _) = makeSUT(stubResult: .failure(stubError))

        do {
            _ = try sut.updateTask(uniqueTask())
            XCTFail("Expect to throws error")
        } catch {
            XCTAssertEqual(error as NSError, stubError)
        }
    }

    private func makeSUT(
        stubResult: Result<Void, Error>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (LocalTaskService, StubTaskStore) {
        let store = StubTaskStore(stubResult: stubResult)
        let sut = LocalTaskService(store: store)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(store, file: file, line: line)

        return (sut, store)
    }
}

private class StubTaskStore: TaskStore {

    private(set) var stubResult: Result<Void, Error>
    private(set) var messages: [Message] = []

    init(stubResult: Result<Void, Error>) {
        self.stubResult = stubResult
    }

    enum Message: Equatable {
        case update(DailyTask)
    }

    func updateTask(_ task: DailyTask) throws {
        messages.append(.update(task))
        try stubResult.get()
    }
}
