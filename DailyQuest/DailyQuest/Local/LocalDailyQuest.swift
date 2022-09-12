//
//  LocalDailyQuest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.12
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

public struct LocalDailyQuest {
    public let id: UUID
    public let createAt: Date
    public let doneAt: Date?
    public let quests: [LocalQuest]

    public init(id: UUID, createAt: Date, doneAt: Date?, quests: [LocalQuest]) {
        self.id = id
        self.createAt = createAt
        self.doneAt = doneAt
        self.quests = quests
    }
}

extension LocalDailyQuest {
    func toDomain() -> DailyQuest {
        return DailyQuest(id: id, createAt: createAt, doneAt: doneAt, quests: quests.map { $0.toDomain() })
    }
}
