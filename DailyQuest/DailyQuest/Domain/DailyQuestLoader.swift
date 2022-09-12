//
//  DailyQuestLoader.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.12
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

public protocol DailyQuestLoader {
    func load(date: Date) async throws -> DailyQuest?
}

