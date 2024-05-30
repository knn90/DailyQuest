//
//  SwiftDataQuestStoreTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 13/5/24.
//

import Foundation
import XCTest

@testable import DailyQuest

final class SwiftDataQuestStoreTests: XCTestCase {

    func test_retrieve_returnNilOnEmptyStore() async throws {
        let sut = try makeSUT()

        let localQuest = try await sut.retrieve(for: "any string")
        XCTAssertNil(localQuest)
    }

    func test_retrieveTwice_OnEmptyStore_staysEmpty() async throws {
        let timestamp = "any timestamp"
        let sut = try makeSUT()

        let firstRetrieval = try await sut.retrieve(for: timestamp)
        XCTAssertNil(firstRetrieval)

        let secondRetrieval = try await sut.retrieve(for: timestamp)
        XCTAssertNil(secondRetrieval)
    }

    func test_retrieve_returnInsertedQuestOnNonEmptyStore() async throws {
        let timestamp = "any timestamp"
        let insertingQuest = uniqueQuest(timestamp: timestamp)
        let sut = try makeSUT()

        try sut.insert(quest: insertingQuest)
        let insertedQuest = try await sut.retrieve(for: timestamp)

        XCTAssertEqual(insertedQuest, insertingQuest)
    }

    func test_retrieveTwice_OnNonEmptyStore_doesNotHaveAnySideEffect() async throws {
        let timestamp = "any timestamp"
        let insertingQuest = uniqueQuest(timestamp: timestamp)
        let sut = try makeSUT()
        
        try sut.insert(quest: insertingQuest)

        let firstRetrieval = try await sut.retrieve(for: timestamp)
        XCTAssertEqual(firstRetrieval, insertingQuest)

        let secondRetrieval = try await sut.retrieve(for: timestamp)
        XCTAssertEqual(secondRetrieval, insertingQuest)
    }

    func test_insertToEmptyStore_savesQuestSuccessful() async throws {
        let timestamp = "any timestamp"
        let insertingQuest = uniqueQuest(timestamp: timestamp)
        let sut = try makeSUT()
        
        let beforeInsertion = try await sut.retrieve(for: timestamp)
        XCTAssertNil(beforeInsertion)

        try sut.insert(quest: insertingQuest)

        let afterInsertion = try await sut.retrieve(for: timestamp)
        XCTAssertNotNil(afterInsertion)
    }

    func test_updateQuest_overrideSavedQuest() async throws {
        let questId = "questId"
        let timestamp = "timestamp"
        let sut = try makeSUT()
        
        let oldQuest = anyQuest(id: questId, timestamp: timestamp, tasks: [])
        try sut.insert(quest: oldQuest)

        let updatingQuest = anyQuest(id: questId, timestamp: timestamp, tasks: orderedTasks())
        try await sut.update(quest:updatingQuest)

        let updatedQuest = try await sut.retrieve(for: timestamp)
        
        XCTAssertEqual(updatedQuest?.id, updatingQuest.id)
        XCTAssertEqual(updatedQuest?.timestamp, updatingQuest.timestamp)
        XCTAssertEqual(Set(updatedQuest!.tasks), Set(updatingQuest.tasks))
    }

    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> SwiftDataQuestStore {
        let sut = try SwiftDataQuestStore(inMemoryOnly: true)
        
        trackForMemoryLeaks(sut, file: file, line: line)

        return sut
    }
}

func orderedTasks() -> [DailyTask] {
    let firstDate = Date()
    let firstTask = DailyTask(id: "first", title: "first title", description: "first description", createdAt: firstDate, isCompleted: false)

    let secondDate = firstDate.addingTimeInterval(1)
    let secondTask = DailyTask(id: "second", title: "second title", description: "second description", createdAt: secondDate, isCompleted: false)
    return [firstTask, secondTask]
}

func unorderedTasks() -> [DailyTask] {
    let firstDate = Date()
    let firstTask = DailyTask(id: "first", title: "first title", description: "first description", createdAt: firstDate, isCompleted: false)

    let secondDate = firstDate.addingTimeInterval(5)
    let secondTask = DailyTask(id: "second", title: "second title", description: "second description", createdAt: secondDate, isCompleted: false)
    return [secondTask, firstTask]
}
