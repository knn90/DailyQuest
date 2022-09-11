//
//  DailyQuestViewModelTests.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 2022.09.11
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import XCTest
@testable import DailyQuest

class DailyQuestViewModelTests: XCTestCase {

    func test_init_setupQuestsArray() {
        let quest = QuestViewModel(id: "an id", title: "a title", isDone: false)
        let anotherQuest = QuestViewModel(id: "another id", title: "another title", isDone: false)
        let quests = [quest, anotherQuest]
        let sut = makeSUT(quests: quests)

        XCTAssertEqual(sut.quests, quests)
    }

    func test_addQuest_insertsNewQuestAtIndex0() {
        let newQuest = QuestViewModel(id: "new id", title: "new quest", isDone: false)
        let oldQuest = QuestViewModel(id: "old id", title: "old quest", isDone: true)
        let sut = makeSUT(quests: [oldQuest])

        sut.add(newQuest)

        XCTAssertEqual(sut.quests, [newQuest, oldQuest])
    }

    private func makeSUT(quests: [QuestViewModel] = []) -> DailyQuestViewModel {
        let sut = DailyQuestViewModel(quests: quests)

        return sut
    }
}
