//
//  LocalDailyTask.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 1/6/24.
//

import Foundation
import SwiftData

@Model
final class LocalDailyTask {
    @Attribute(.unique) var taskId: String
    var title: String
    var taskDescription: String
    var createdAt: Date
    var isCompleted: Bool
    var quest: LocalDailyQuest?

    init(taskId: String, title: String, taskDescription: String, createdAt: Date, isCompleted: Bool) {
        self.taskId = taskId
        self.title = title
        self.taskDescription = taskDescription
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }

    static func fetchDescriptor(taskId: String) -> FetchDescriptor<LocalDailyTask> {
        var fetchDescriptor = FetchDescriptor<LocalDailyTask>(
            predicate: #Predicate { task in
                task.taskId == taskId
            })

        fetchDescriptor.fetchLimit = 1

        return fetchDescriptor
    }
}
