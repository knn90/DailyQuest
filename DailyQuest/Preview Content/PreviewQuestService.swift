//
//  PreviewQuestService.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation
import QuestServices

final class PreviewQuestService: QuestService {
    func getTodayQuest() -> DailyQuest {
        DailyQuest(
            id: "",
            timestamp: "",
            tasks: [
                DailyTask(id: "1", title: "Short task", description: "short description", createdAt: Date(), isCompleted: false),
                DailyTask(id: "2", title: "Second short task", description: "do something really long long long long time. It's not enought. It's should be longer", createdAt: Date(), isCompleted: false),
                DailyTask(id: "3", title: "Long task", description: "Not so long description", createdAt: Date(), isCompleted: false),
                DailyTask(id: "4", title: "Super long long long long long long long task", description: "do something really long long long long time. It's not enought. It's should be longer", createdAt: Date(), isCompleted: false)
            ]
        )
    }

    func updateQuest(_ quest: DailyQuest) throws {
    }
}
