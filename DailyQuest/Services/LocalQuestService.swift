//
//  LocalQuestService.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 10/5/24.
//

import Foundation

final class LocalQuestService: QuestService {
    private let repository: QuestRepository

    init(repository: QuestRepository) {
        self.repository = repository
    }

    func getDailyQuest() async throws -> [DailyTask] {
        try await repository.fetch()
    }
}
