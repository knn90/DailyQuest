//
//  TaskStore.swift
//
//
//  Created by Khoi Nguyen on 2/7/24.
//

import Foundation
import QuestServices

public protocol TaskStore {
    func updateTask(_ task: DailyTask) throws
}
