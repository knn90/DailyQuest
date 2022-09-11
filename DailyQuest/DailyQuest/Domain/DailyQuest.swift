//
//  DailyQuest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.11
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

public struct DailyQuest {
    let id: UUID
    let createAt: Date
    let doneAt: Date
    let quests: [Quest]

    public init(id: UUID, createAt: Date, doneAt: Date, quests: [Quest]) {
        self.id = id
        self.createAt = createAt
        self.doneAt = doneAt
        self.quests = quests
    }
}
