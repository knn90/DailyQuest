//
//  Helpers.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 8/5/24.
//

import Foundation
import QuestServices
@testable import DailyQuest

func uniqueQuest(timestamp: Date = fixedDate(), tasks: [DailyTask] = []) -> DailyQuest {
    DailyQuest(id: UUID().uuidString, timestamp: timestamp, tasks: tasks)
}

func emptyQuest() -> DailyQuest {
    DailyQuest(id: "", timestamp: fixedDate(), tasks: [])
}
func anyQuest(id: String, timestamp: Date, tasks: [DailyTask]) -> DailyQuest {
    DailyQuest(id: id, timestamp: timestamp, tasks: tasks)
}

func uniqueTask() -> DailyTask {
    DailyTask(
        id: UUID().uuidString,
        title: "unique title",
        description: "unique description", 
        createdAt: Date(),
        isCompleted: false)
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: -10010, userInfo: nil)
}

func fixedDate() -> Date {
    Date(timeIntervalSince1970: 949389572)
}
