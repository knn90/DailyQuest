//
//  QuestStore.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 1/6/24.
//

import Foundation
import QuestServices

protocol QuestStore {
    func retrieve() throws -> DailyQuest?
    func insert(quest: DailyQuest) throws
    func update(quest: DailyQuest) throws
    func addTask(_ task: DailyTask) throws
    func reset(quest: DailyQuest) throws
}
