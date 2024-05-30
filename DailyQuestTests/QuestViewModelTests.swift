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
        let sut = makeSUT(stubResult: .success(emptyQuest()))

        await sut.getDailyQuest()

        XCTAssertTrue(sut.tasks.isEmpty)
    }

    @MainActor
    func test_getDailyQuest_updatesTasks_getDailyQuestSuccessWithNonEmptyArray() async {
        let stubTasks = [uniqueTask(), uniqueTask(), uniqueTask()]
        let sut = makeSUT(stubResult: .success(uniqueQuest(tasks: stubTasks)))

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
    private func makeSUT(
        stubResult: Result<DailyQuest, Error> = .success(emptyQuest()),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> QuestViewModel {
        let service = StubQuestService(stubResult: stubResult)
        let sut = QuestViewModel(service: service)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(service, file: file, line: line)

        return sut
    }
}

final class StubQuestService: QuestService {
    private(set) var stubResult: Result<DailyQuest, Error>

    init(stubResult: Result<DailyQuest, Error>) {
        self.stubResult = stubResult
    }

    func getTodayQuest() async throws -> DailyQuest {
        return try stubResult.get()
    }
}



