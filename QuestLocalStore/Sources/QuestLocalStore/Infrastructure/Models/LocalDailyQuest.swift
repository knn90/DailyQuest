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
    var id: String
    @Attribute(.unique)
    var timestamp: Date
    @Relationship(deleteRule: .cascade, inverse: \LocalDailyTask.quest)
    var tasks: [LocalDailyTask]


    init(id: String, timestamp: Date, tasks: [LocalDailyTask]) {
        self.id = id
        self.timestamp = timestamp
        self.tasks = tasks
    }

    static func fetchDescriptor() -> FetchDescriptor<LocalDailyQuest> {
        return FetchDescriptor<LocalDailyQuest>()
    }
}
