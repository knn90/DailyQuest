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
            QuestViewModel(title: "Do something", isDone: false),
            QuestViewModel(title: "Do another thing", isDone: true),
            QuestViewModel(title: "Do 1 something", isDone: false),
            QuestViewModel(title: "Do 2 another thing", isDone: true),
            QuestViewModel(title: "Do 3 something", isDone: false),
            QuestViewModel(title: "Do 4 another thing", isDone: true),
            QuestViewModel(title: "Do 5 something", isDone: false),
            QuestViewModel(title: "Do 6 another thing", isDone: true),
            QuestViewModel(title: "Do 7 something", isDone: false),
            QuestViewModel(title: "Do 8 another thing", isDone: true),
            QuestViewModel(title: "Do a quest with super long description so it can't be display in one line. But it's 3 lines", isDone: true),
        ])
    }
}
#endif
