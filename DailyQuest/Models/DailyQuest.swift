//
//  DailyQuest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 30/5/24.
//

import Foundation

struct DailyQuest: Equatable {
    let id: String
    let timestamp: String
    let tasks: [DailyTask]
}
