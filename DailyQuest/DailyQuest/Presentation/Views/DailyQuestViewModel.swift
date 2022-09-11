//
//  DailyQuestViewModel.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.11
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

final class DailyQuestViewModel: ObservableObject {
    @Published private(set) var quests: [QuestViewModel]

    init(quests: [QuestViewModel]) {
        self.quests = quests
    }

    func add(_ quest: QuestViewModel) {
        quests.insert(quest, at: 0)
    }
}
