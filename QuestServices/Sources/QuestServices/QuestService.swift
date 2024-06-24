//
//  QuestService.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 9/5/24.
//

import Foundation

public protocol QuestService {
    func getTodayQuest() async throws -> DailyQuest
    func updateQuest(_ quest: DailyQuest) throws 
    func addTask(title: String) throws
}

