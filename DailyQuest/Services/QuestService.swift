//
//  QuestService.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 9/5/24.
//

import Foundation

protocol QuestService {
    func getDailyQuest() async throws -> [DailyTask]
}