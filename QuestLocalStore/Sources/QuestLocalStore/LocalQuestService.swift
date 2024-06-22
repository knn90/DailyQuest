//
//  LocalQuestService.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 10/5/24.
//

import Foundation
import QuestServices

public final class LocalQuestService: QuestService {
    private let store: QuestStore

    public init(store: QuestStore) {
        self.store = store
    }

    public func getTodayQuest() throws -> DailyQuest {
        let todayTimestamp = TimestampGenerator.generateTodayTimestamp()
        if let todayQuest = try store.retrieve(for: todayTimestamp) {
            return todayQuest
        } else {
            let newQuest = DailyQuest(id: UUID().uuidString, timestamp: todayTimestamp, tasks: [])
            try store.insert(quest: newQuest)
            return newQuest
        }
    }

    public func updateQuest(_ quest: DailyQuest) throws {
        try store.update(quest: quest)
        
    }
}
