//
//  DailyQuest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 30/5/24.
//

import Foundation

public struct DailyQuest: Equatable {
    public let id: String
    public let timestamp: Date
    public let tasks: [DailyTask]

    public init(id: String, timestamp: Date, tasks: [DailyTask]) {
        self.id = id
        self.timestamp = timestamp
        self.tasks = tasks
    }
}
