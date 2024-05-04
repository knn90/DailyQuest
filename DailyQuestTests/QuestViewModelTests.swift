//
//  QuestViewModelTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation
import XCTest

@testable import DailyQuest

final class QuestViewModelTests: XCTestCase {
    func test_getDailyQuest_sendsRequestToQuestService() {
        let service = StubQuestService()
        let sut = QuestViewModel(service: service)

        XCTAssertFalse(service.isGetDailyQuestCalled)
        sut.getDailyQuest()

        XCTAssertTrue(service.isGetDailyQuestCalled)
    }
}

final class StubQuestService: QuestService {
    private(set) var isGetDailyQuestCalled = false

    func getDailyQuest() {
        isGetDailyQuestCalled = true
    }
}
