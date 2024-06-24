//
//  QuestViewModelTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation
import XCTest
import Combine
@testable import QuestPresentation

final class QuestViewModelTests: XCTestCase {
    var disposeBag: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        disposeBag = Set<AnyCancellable>()
    }

    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
    
    @MainActor
    func test_tasks_isEmptyUponCreation() {
        let sut = makeSUT()

        XCTAssertTrue(sut.tasks.isEmpty)
    }

    @MainActor
    func test_getDailyQuest_updatesIsLoadingStateCorrectly_getDailyQuestSuccess() async {
        let sut = makeSUT()
        var captureIsLoadingState = [Bool]()
        sut.$isLoading
            .sink(receiveValue: { captureIsLoadingState.append($0)})
            .store(in: &disposeBag)

        await sut.getDailyQuest()

        XCTAssertEqual(captureIsLoadingState, [false, true, false])
    }

    @MainActor
    func test_getDailyQuest_updatesIsLoadingStateCorrectly_getDailyQuestFailed() async {
        let sut = makeSUT(stubResult: .failure(anyNSError()))
        var captureIsLoadingState = [Bool]()
        sut.$isLoading
            .sink(receiveValue: { captureIsLoadingState.append($0)})
            .store(in: &disposeBag)

        await sut.getDailyQuest()

        XCTAssertEqual(captureIsLoadingState, [false, true, false])
    }

    @MainActor
    func test_getDailyQuest_tasksStayEmpty_getDailyQuestSuccessWithEmpty() async {
        let sut = makeSUT(stubResult: .success([]))

        await sut.getDailyQuest()

        XCTAssertTrue(sut.tasks.isEmpty)
    }

    @MainActor
    func test_getDailyQuest_updatesTasks_getDailyQuestSuccessWithNonEmptyArray() async {
        let stubTasks = [uniqueTask(), uniqueTask(), uniqueTask()]
        let sut = makeSUT(stubResult: .success(stubTasks))

        await sut.getDailyQuest()

        XCTAssertEqual(sut.tasks, stubTasks)
    }

    @MainActor
    func test_getDailyQuest_updatesisShowingErrorToTrue_getDailyQuestFailed() async {
        let sut = makeSUT(stubResult: .failure(anyNSError()))

        XCTAssertFalse(sut.isShowingError)
        await sut.getDailyQuest()
        XCTAssertTrue(sut.isShowingError)
    }

    @MainActor
    func test_addTask_updatesisShowingErrorToTrue_addTaskFailed() async {
        let sut = makeSUT(stubAddTaskResult: .failure(anyNSError()))

        XCTAssertFalse(sut.isShowingError)
        await sut.addTask(title: "title")
        XCTAssertTrue(sut.isShowingError)
    }

    @MainActor
    func test_addTask_appendsNewTaskToTasksArray_addTaskSuccessful() async {
        let title = "Any Title"
        let task = PresentationTask(id: "any", title: title, description: "", isCompleted: true)
        let sut = makeSUT(stubAddTaskResult: .success(task))

        XCTAssertTrue(sut.tasks.isEmpty)
        await sut.addTask(title: title)
        XCTAssertEqual(sut.tasks, [task])
    }

    @MainActor
    private func makeSUT(
        stubResult: Result<[PresentationTask], Error> = .failure(anyNSError()),
        stubAddTaskResult: Result<PresentationTask, Error> = .failure(anyNSError()),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> QuestViewModel {
        let delegate = StubDelegate(stubResult: stubResult, stubAddTaskResult: stubAddTaskResult)
        let sut = QuestViewModel(delegate: delegate)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(delegate, file: file, line: line)

        return sut
    }
}

final class StubDelegate: QuestViewModelDelegate {

    private(set) var stubResult: Result<[PresentationTask], Error>
    private(set) var stubAddTaskResult: Result<PresentationTask, Error>

    init(
        stubResult: Result<[PresentationTask], Error>,
        stubAddTaskResult: Result<PresentationTask, Error>
    ) {
        self.stubResult = stubResult
        self.stubAddTaskResult = stubAddTaskResult
    }

    func getDailyTasks() async throws -> [PresentationTask] {
        return try stubResult.get()
    }

    func addTask(title: String) throws -> PresentationTask {
        return try stubAddTaskResult.get()

    }
}
