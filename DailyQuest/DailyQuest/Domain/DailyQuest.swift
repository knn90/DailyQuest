//
//  DailyQuest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.11
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

struct DailyQuest {
    let id: UUID
    let createAt: Date
    let doneAt: Date
    let quests: [Quest]
}
