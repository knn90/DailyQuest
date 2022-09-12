//
//  SharedHelper.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 2022.09.12
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation
import DailyQuest

func anyNSError() -> NSError {
    NSError(domain: "any", code: -1)
}

func anyDailyQuest() -> DailyQuest {
    DailyQuest(id: UUID(), createAt: anyFixedDate(), doneAt: anyFixedDate(), quests: [])
}

func anyLocalDailyQuest() -> LocalDailyQuest {
    LocalDailyQuest(id: UUID(), createAt: anyFixedDate(), doneAt: nil, quests: [])
}

func anyFixedDate() -> Date {
    Date(timeIntervalSince1970: 3453463543)
}

func uniqueDailyQuest() -> (model: DailyQuest, local: LocalDailyQuest) {
    let id = UUID()
    let createdAt = anyFixedDate()
    let questId = UUID()
    let title = "any title"
    let isDone = false
    let model = DailyQuest(id: id, createAt: createdAt, doneAt: nil, quests: [Quest(id: questId, title: title, isDone: isDone)])
    let local = LocalDailyQuest(id: id, createAt: createdAt, doneAt: nil, quests: [LocalQuest(id: questId, title: title, isDone: isDone)])

    return (model, local)
}

extension Date {
    func add(day: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: day, to: self)!
    }
}
