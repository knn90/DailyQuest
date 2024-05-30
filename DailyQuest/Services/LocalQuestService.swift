//
//  LocalQuestService.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 10/5/24.
//

import Foundation

final class LocalQuestService: QuestService {
    private let store: QuestStore

    init(store: QuestStore) {
        self.store = store
    }

    func getTodayQuest() async throws -> DailyQuest {
        let todayTimestamp = TimestampGenerator.generateTodayTimestamp()
        return try await store.retrieve(for: todayTimestamp)!
    }
}
