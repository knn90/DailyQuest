//
//  QuestRepository.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 10/5/24.
//

import Foundation

protocol QuestRepository {
    func fetch() async throws -> [DailyTask]
}
