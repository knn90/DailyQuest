//
//  PreviewQuestService.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation

final class PreviewQuestService: QuestService {
    func getDailyQuest() -> [DailyTask] {
        [
            DailyTask(id: "1", title: "Short task", description: "short description", isCompleted: false),
            DailyTask(id: "2", title: "Second short task", description: "do something really long long long long time. It's not enought. It's should be longer", isCompleted: false),
            DailyTask(id: "3", title: "Long task", description: "Not so long description", isCompleted: false),
            DailyTask(id: "4", title: "Super long long long long long long long task", description: "do something really long long long long time. It's not enought. It's should be longer", isCompleted: false)
        ]
    }
}
