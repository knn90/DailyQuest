//
//  SwiftDataQuestStoreTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 13/5/24.
//

import Foundation
import XCTest
import QuestServices

@testable import QuestLocalStore

final class SwiftDataQuestStoreTests: XCTestCase {

    func test_retrieve_returnNilOnEmptyStore() throws {
        let sut = try makeSUT()

        let localQuest = try sut.retrieve()
        XCTAssertNil(localQuest)
    }

    func test_retrieveTwice_OnEmptyStore_staysEmpty() throws {
        let sut = try makeSUT()

        let firstRetrieval = try sut.retrieve()
        XCTAssertNil(firstRetrieval)

        let secondRetrieval = try sut.retrieve()
        XCTAssertNil(secondRetrieval)
    }

    func test_retrieve_returnInsertedQuestOnNonEmptyStore() throws {
        let insertingQuest = uniqueQuest()
        let sut = try makeSUT()

        try sut.insert(quest: insertingQuest)
        let insertedQuest = try sut.retrieve()

        XCTAssertEqual(insertedQuest, insertingQuest)
    }

    func test_retrieveTwice_OnNonEmptyStore_doesNotHaveAnySideEffect() throws {
        let timestamp = Date(timeIntervalSince1970: 9383202462)
        let insertingQuest = uniqueQuest(timestamp: timestamp)
        let sut = try makeSUT()
        
        try sut.insert(quest: insertingQuest)

        let firstRetrieval = try sut.retrieve()
        XCTAssertEqual(firstRetrieval, insertingQuest)

        let secondRetrieval = try sut.retrieve()
        XCTAssertEqual(secondRetrieval, insertingQuest)
    }

    func test_insertToEmptyStore_savesQuestSuccessful() throws {
        let timestamp = Date(timeIntervalSince1970: 947239357230)
        let tasks = [uniqueTask(), uniqueTask()]
        let insertingQuest = uniqueQuest(timestamp: timestamp, tasks: tasks)
        let sut = try makeSUT()
        
        let beforeInsertion = try sut.retrieve()
        XCTAssertNil(beforeInsertion)

        try sut.insert(quest: insertingQuest)
        let afterInsertion = try sut.retrieve()
        XCTAssertNotNil(afterInsertion)
        XCTAssertEqual(afterInsertion?.tasks.count, tasks.count)
        XCTAssertTrue(afterInsertion!.tasks.contains(tasks.first!))
        XCTAssertTrue(afterInsertion!.tasks.contains(tasks.last!))
    }

    func test_addTask_throwsQuestNotFoundErrorOnEmptyStore() throws {
        let sut = try makeSUT()

        do {
            try sut.addTask(uniqueTask())
            XCTFail("Expect to throws quest not found error")
        } catch {
            XCTAssertEqual(error as? SwiftDataQuestStore.Error, SwiftDataQuestStore.Error.questNotFound)
        }
    }

    func test_addTask_appendTaskToTaskArray() throws {
        let questId = "questId"
        let timestamp = Date(timeIntervalSince1970: 9348289582)
        let sut = try makeSUT()
        
        let oldQuest = anyQuest(id: questId, timestamp: timestamp, tasks: [])
        try sut.insert(quest: oldQuest)

        let task1 = anyTask(title: "Task 1")
        try sut.addTask(task1)

        let updatedQuest = try sut.retrieve()
        XCTAssertEqual(updatedQuest?.id, oldQuest.id)
        XCTAssertEqual(updatedQuest?.timestamp, oldQuest.timestamp)
        XCTAssertEqual(updatedQuest?.tasks.last, task1)
        
        let task2 = anyTask(title: "Task 2")
        try sut.addTask(task2)
        let updatedQuest2 = try sut.retrieve()
        XCTAssertEqual(updatedQuest2?.id, oldQuest.id)
        XCTAssertEqual(updatedQuest2?.timestamp, oldQuest.timestamp)
        XCTAssertEqual(updatedQuest2?.tasks.count, 2)
        XCTAssertEqual(Set(updatedQuest2!.tasks), [task1, task2])

        let task3 = anyTask(title: "Task 3")
        try sut.addTask(task3)
        let updatedQuest3 = try sut.retrieve()
        XCTAssertEqual(updatedQuest3?.id, oldQuest.id)
        XCTAssertEqual(updatedQuest3?.timestamp, oldQuest.timestamp)
        XCTAssertEqual(updatedQuest3?.tasks.count, 3)
        XCTAssertEqual(Set(updatedQuest3!.tasks), [task1, task2, task3])
    }

    func test_updateTask_throwsTaskNotFoundErrorOnEmptyStore() throws {
        let sut = try makeSUT()

        do {
            try sut.updateTask(uniqueTask())
            XCTFail("Expect to throws quest not found error")
        } catch {
            XCTAssertEqual(error as? SwiftDataQuestStore.Error, SwiftDataQuestStore.Error.taskNotFound)
        }
    }

    func test_updateTask_overrideCurrentTaskWithLatestOne() throws {
        let sut = try makeSUT()
        let task = uniqueTask()
        let updatedTask = DailyTask(id: task.id, title: "updatedTask", description: "updatedDescription", createdAt: Date(), isCompleted: true)

        let quest = uniqueQuest(tasks: [task])
        try sut.insert(quest: quest)
        let insertedQuest = try sut.retrieve()
        XCTAssertNotNil(insertedQuest?.tasks)
        XCTAssertFalse(insertedQuest!.tasks.isEmpty)

        try sut.updateTask(updatedTask)
        let receivedQuest = try sut.retrieve()
        XCTAssertNotNil(receivedQuest?.tasks)
        XCTAssertFalse(receivedQuest!.tasks.isEmpty)
        XCTAssertEqual(receivedQuest?.tasks.first, updatedTask)
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
