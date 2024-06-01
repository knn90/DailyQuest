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
    @Attribute(.unique) var id: String
    var title: String
    var taskDescription: String
    var createdAt: Date
    var isCompleted: Bool
    var quest: LocalDailyQuest?

    init(id: String, title: String, taskDescription: String, createdAt: Date, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
