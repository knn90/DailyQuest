//
//  QuestService.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 9/5/24.
//

import Foundation

protocol QuestService {
    func getTodayQuest() throws -> DailyQuest
    func updateQuest(_ quest: DailyQuest) throws 
}
