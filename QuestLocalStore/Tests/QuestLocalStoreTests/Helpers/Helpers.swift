//
//  Helpers.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 8/5/24.
//

import Foundation
import QuestServices
@testable import QuestLocalStore

func uniqueQuest(timestamp: Date = fixedDate(), tasks: [DailyTask] = []) -> DailyQuest {
    DailyQuest(id: UUID().uuidString, timestamp: timestamp, tasks: tasks)
}

func emptyQuest() -> DailyQuest {
    DailyQuest(id: "", timestamp: fixedDate(), tasks: [])
}
func anyQuest(id: String, timestamp: Date, tasks: [DailyTask]) -> DailyQuest {
    DailyQuest(id: id, timestamp: fixedDate(), tasks: tasks)
}

func anyTask(
    id: String = UUID().uuidString,
    title: String,
    description: String = "",
    createdAt: Date = Date(),
    isCompleted: Bool = false
) -> DailyTask {
    DailyTask(
        id: id,
        title: title,
        description: description,
        createdAt: createdAt,
        isCompleted: isCompleted)
}

func uniqueTask() -> DailyTask {
    DailyTask(
        id: UUID().uuidString,
        title: "unique title",
        description: "unique description", 
        createdAt: Date(),
        isCompleted: false)
}

func completedTask() -> DailyTask {
    DailyTask(
        id: UUID().uuidString,
        title: "unique title",
        description: "unique description",
        createdAt: Date(),
        isCompleted: true)
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: -10010, userInfo: nil)
}

func fixedDate() -> Date {
    Date(timeIntervalSince1970: 4852390935)
}
