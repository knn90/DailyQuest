//
//  LocalTaskService.swift
//
//
//  Created by Khoi Nguyen on 2/7/24.
//

import Foundation
import QuestServices

final class LocalTaskService: TaskService {
    let store: TaskStore

    init(store: TaskStore) {
        self.store = store
    }

    func updateTask(_ task: DailyTask) throws {
        try store.updateTask(task)
    }
}
