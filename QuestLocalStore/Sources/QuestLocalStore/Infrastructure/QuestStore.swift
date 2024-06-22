//
//  QuestStore.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 1/6/24.
//

import Foundation
import QuestServices

public protocol QuestStore {
    func retrieve(for date: String) throws -> DailyQuest?
    func insert(quest: DailyQuest) throws
    func update(quest: DailyQuest) throws
}
