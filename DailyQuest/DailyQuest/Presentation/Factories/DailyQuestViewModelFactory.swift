//
//  DailyQuestViewModelFactory.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.11
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

#if DEBUG
final class DailyQuestViewModelFactory {
    static func make() -> DailyQuestViewModel {
        DailyQuestViewModel(quests: [
            QuestViewModel(id: UUID().uuidString, title: "Do something", isDone: false),
            QuestViewModel(id: UUID().uuidString, title: "Do another thing", isDone: true),
            QuestViewModel(id: UUID().uuidString, title: "Do 1 something", isDone: false),
            QuestViewModel(id: UUID().uuidString, title: "Do 2 another thing", isDone: true),
            QuestViewModel(id: UUID().uuidString, title: "Do 3 something", isDone: false),
            QuestViewModel(id: UUID().uuidString, title: "Do 4 another thing", isDone: true),
            QuestViewModel(id: UUID().uuidString, title: "Do 5 something", isDone: false),
            QuestViewModel(id: UUID().uuidString, title: "Do 6 another thing", isDone: true),
            QuestViewModel(id: UUID().uuidString, title: "Do 7 something", isDone: false),
            QuestViewModel(id: UUID().uuidString, title: "Do 8 another thing", isDone: true),
            QuestViewModel(id: UUID().uuidString, title: "Do a quest with super long description so it can't be display in one line. But it's 3 lines", isDone: true),
        ])
    }
}
#endif
