//
//  Helpers.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 8/5/24.
//

import Foundation
@testable import DailyQuest

func uniqueQuest(timestamp: String = UUID().uuidString, tasks: [DailyTask] = []) -> DailyQuest {
    DailyQuest(id: UUID().uuidString, timestamp: timestamp, tasks: tasks)
}

func emptyQuest() -> DailyQuest {
    DailyQuest(id: "", timestamp: "", tasks: [])
}
func anyQuest(id: String, timestamp: String, tasks: [DailyTask]) -> DailyQuest {
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
