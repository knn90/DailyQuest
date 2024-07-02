//
//  TaskStore.swift
//
//
//  Created by Khoi Nguyen on 2/7/24.
//

import Foundation
import QuestServices

protocol TaskStore {
    func updateTask(_ task: DailyTask) throws
}
