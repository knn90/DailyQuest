//
//  LocalDailyQuest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 1/6/24.
//

import Foundation
import SwiftData

@Model
final class LocalDailyQuest {
    @Attribute(.unique)
    var questId: String
    @Attribute(.unique)
    var timestamp: Date
    @Relationship(deleteRule: .cascade, inverse: \LocalDailyTask.quest)
    var tasks: [LocalDailyTask]


    init(questId: String, timestamp: Date, tasks: [LocalDailyTask]) {
        self.questId = questId
        self.timestamp = timestamp
        self.tasks = tasks
    }

    static func fetchDescriptor() -> FetchDescriptor<LocalDailyQuest> {
        return FetchDescriptor<LocalDailyQuest>()
    }
}
