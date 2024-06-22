//
//  DailyTask.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import Foundation

public struct DailyTask: Identifiable, Hashable {
    public let id: String
    public let title: String
    public let description: String
    public let createdAt: Date
    public var isCompleted: Bool

    public init(id: String, title: String, description: String, createdAt: Date, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.createdAt = createdAt
        self.isCompleted = isCompleted
    }
}
