//
//  TaskViewModelTests.swift
//
//
//  Created by Khoi Nguyen on 29/6/24.
//

import Foundation
import XCTest
@testable import QuestPresentation

final class TaskViewModelTests: XCTestCase {
    func test_updateTask_sendRequestToService() {
        let task = uniqueTask()
        let (sut, delegate) = makeSUT(task: task)
        sut.updateTask(task)

        XCTAssertTrue(delegate.isUpdateTaskCalled)
        XCTAssertEqual(delegate.updatedTask, task)
    }

    private func makeSUT(
        task: PresentationTask,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (TaskViewModel, SpyTaskViewModelDelegate) {
        let delegate = SpyTaskViewModelDelegate()
        let sut = TaskViewModel(task: task, delegate: delegate)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(delegate, file: file, line: line)

        return (sut, delegate)
    }
}

private final class SpyTaskViewModelDelegate: TaskViewModelDelegate {
    private(set) var isUpdateTaskCalled = false
    private(set) var updatedTask: PresentationTask?

    func updateTask(_ task: PresentationTask) {
        isUpdateTaskCalled = true
        updatedTask = task
    }
}
