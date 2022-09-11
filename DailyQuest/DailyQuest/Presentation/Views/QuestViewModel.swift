//
//  QuestViewModel.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.11
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

struct QuestViewModel: Hashable {
    let id: String
    let title: String
    var isDone: Bool
}

extension QuestViewModel: Identifiable { } 
