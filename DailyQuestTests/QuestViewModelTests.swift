//
//  QuestViewModelTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation
import XCTest
import Combine

@testable import DailyQuest

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

    func test_tasks_isEmptyUponCreation() {
        let (sut, _) = makeSUT()

        XCTAssertTrue(sut.tasks.isEmpty)
    }

    func test_getDailyQuest_sendsRequestToQuestService() async {
        let (sut, service) = makeSUT()

        XCTAssertFalse(service.isGetDailyQuestCalled)
        await sut.getDailyQuest()

        XCTAssertTrue(service.isGetDailyQuestCalled)
    }

    func test_getDailyQuest_updatesIsLoadingStateCorrectly() async {
        let (sut, _) = makeSUT()
        var captureIsLoadingState = [Bool]()
        sut.$isLoading
            .sink(receiveValue: { captureIsLoadingState.append($0)})
            .store(in: &disposeBag)

        await sut.getDailyQuest()

        XCTAssertEqual(captureIsLoadingState, [false, true, false])
    }

    func test_getDailyQuest_tasksStayEmptyWhenGetDailyQuestSuccessWithEmpty() async {
        let (sut, _) = makeSUT(stubResult: .success([]))

        await sut.getDailyQuest()

        XCTAssertTrue(sut.tasks.isEmpty)
    }

    func test_getDailyQuest_updatesTasksWhenGetDailyQuestSuccessWithNonEmptyArray() async {
        let stubTasks = [uniqueTask(), uniqueTask(), uniqueTask()]
        let (sut, _) = makeSUT(stubResult: .success(stubTasks))

        await sut.getDailyQuest()

        XCTAssertEqual(sut.tasks, stubTasks)
    }

    private func makeSUT(
        stubResult: Result<[DailyTask], Error> = .success([]),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (QuestViewModel, StubQuestService) {
        let service = StubQuestService(stubResult: stubResult)
        let sut = QuestViewModel(service: service)
        
        trackForMemoryLeak(sut, file: file, line: line)
        trackForMemoryLeak(service, file: file, line: line)

        return (sut, service)
    }
}

final class StubQuestService: QuestService {
    private(set) var isGetDailyQuestCalled = false
    private(set) var stubResult: Result<[DailyTask], Error>

    init(stubResult: Result<[DailyTask], Error>) {
        self.stubResult = stubResult
    }

    func getDailyQuest() async -> [DailyTask] {
        isGetDailyQuestCalled = true
        return (try? stubResult.get()) ?? []
    }
}

extension XCTestCase {
    func trackForMemoryLeak(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance is not dealocated. Potential memory leak", file: file, line: line)
        }
    }
}

func uniqueTask() -> DailyTask {
    DailyTask(
        id: UUID().uuidString,
        title: "unique title",
        description: "unique description",
        isCompleted: false)
}
