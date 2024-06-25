//
//  QuestService.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 9/5/24.
//

import Foundation

public protocol QuestService {
    func getQuest(date: Date) async throws -> DailyQuest
    func addTask(title: String) async throws -> DailyTask
}

