//
//  DailyTask.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import Foundation

struct DailyTask: Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let createdAt: Date
    var isCompleted: Bool
}
