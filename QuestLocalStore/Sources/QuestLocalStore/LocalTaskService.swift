//
//  LocalTaskService.swift
//
//
//  Created by Khoi Nguyen on 2/7/24.
//

import Foundation
import QuestServices

public final class LocalTaskService: TaskService {
    private let store: TaskStore
    
    public init(store: TaskStore) {
        self.store = store
    }

    public func updateTask(_ task: DailyTask) throws {
        try store.updateTask(task)
    }
}
