//
//  Helpers.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 8/5/24.
//

import Foundation
import QuestServices

func uniqueQuest(timestamp: String = UUID().uuidString, tasks: [DailyTask] = []) -> DailyQuest {
    DailyQuest(id: UUID().uuidString, timestamp: fixedDate(), tasks: tasks)
}

func emptyQuest() -> DailyQuest {
    DailyQuest(id: "", timestamp: fixedDate(), tasks: [])
}
func anyQuest(id: String, timestamp: Date, tasks: [DailyTask]) -> DailyQuest {
    DailyQuest(id: id, timestamp: fixedDate(), tasks: tasks)
}

func uniqueTask() -> DailyTask {
    DailyTask(
        id: UUID().uuidString,
        title: "unique title",
        description: "unique description", 
        createdAt: Date(),
        isCompleted: false)
}

func fixedDate() -> Date {
    Date(timeIntervalSince1970: 1234567890)
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: -10010, userInfo: nil)
}
