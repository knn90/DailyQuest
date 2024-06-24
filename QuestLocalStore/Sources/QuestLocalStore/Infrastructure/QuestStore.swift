//
//  QuestStore.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 1/6/24.
//

import Foundation
import QuestServices

protocol QuestStore {
    func retrieve(for date: String) throws -> DailyQuest?
    func insert(quest: DailyQuest) throws
    func addTask(_ task: DailyTask, for date: String) throws
}
