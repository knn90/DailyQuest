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


    func test_getDailyQuest_sendsRequestToQuestService() async {
        let service = StubQuestService()
        let sut = QuestViewModel(service: service)

        XCTAssertFalse(service.isGetDailyQuestCalled)
        await sut.getDailyQuest()

        XCTAssertTrue(service.isGetDailyQuestCalled)
    }

    func test_getDailyQuest_updatesIsLoadingStateCorrectly() async {
        let service = StubQuestService()
        let sut = QuestViewModel(service: service)
        var captureIsLoadingState = [Bool]()
        sut.$isLoading
            .sink(receiveValue: { captureIsLoadingState.append($0)})
            .store(in: &disposeBag)

        await sut.getDailyQuest()

        XCTAssertEqual(captureIsLoadingState, [false, true, false])
    }
}

final class StubQuestService: QuestService {
    private(set) var isGetDailyQuestCalled = false

    func getDailyQuest() async {
        isGetDailyQuestCalled = true
    }

    func getDailyQuestCompleted() {

    }
}
