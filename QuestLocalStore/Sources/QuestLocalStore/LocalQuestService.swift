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

    public func getQuest(date: Date) throws -> DailyQuest {
        let calendar = Calendar.current
        if let todayQuest = try store.retrieve() {
            if calendar.isDate(todayQuest.timestamp, equalTo: date, toGranularity: .day) {
                return todayQuest
            } else {
                return try store.reset(quest: todayQuest)
            }
        } else {
            let newQuest = DailyQuest(id: UUID().uuidString, timestamp: Date(), tasks: [])
            try store.insert(quest: newQuest)
            return newQuest
        }
    }

    public func addTask(title: String) throws -> DailyTask {
        let task = DailyTask(id: UUID().uuidString, title: title, description: "", createdAt: Date(), isCompleted: false)
        try store.addTask(task)

        return task
    }
}
