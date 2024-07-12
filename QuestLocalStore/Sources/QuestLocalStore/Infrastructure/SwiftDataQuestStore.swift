//
//  QuestRepository.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 10/5/24.
//

import Foundation
import SwiftData
import QuestServices

final class SwiftDataQuestStore: QuestStore {
    private let container: ModelContainer
    private let context: ModelContext

    enum Error: Swift.Error {
        case questNotFound
        case taskNotFound
    }

    init(inMemoryOnly: Bool = false) throws {
        let schema = Schema([LocalDailyQuest.self, LocalDailyTask.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemoryOnly)
        self.container = try ModelContainer(for: schema, configurations: config)
        self.context = ModelContext(container)
    }

    func retrieve() throws -> DailyQuest? {
        let localQuest = try context
            .fetch(LocalDailyQuest.fetchDescriptor())
        
        return localQuest.first?.toModel()
    }

    func insert(quest: DailyQuest) throws {
        let localQuest = quest.toLocal()
        context.insert(localQuest)
        try saveIfNeeded()
    }

    func update(quest: DailyQuest) throws {
        guard let oldQuest = try context.fetch(LocalDailyQuest.fetchDescriptor()).first else {
            throw Error.questNotFound
        }
        context.delete(oldQuest)
        context.insert(quest.toLocal())
        try saveIfNeeded()
    }

    func addTask(_ task: DailyTask) throws {
        guard let quest = try context.fetch(LocalDailyQuest.fetchDescriptor()).first else {
            throw Error.questNotFound
        }
        let localTask = task.toLocal()
        localTask.quest = quest
        quest.tasks.append(localTask)
        try saveIfNeeded()
    }

    private func saveIfNeeded() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}

extension SwiftDataQuestStore: TaskStore {
    func updateTask(_ task: DailyTask) throws {
        guard let foundTask = try context.fetch(LocalDailyTask.fetchDescriptor(taskId: task.id)).first else {
            throw Error.taskNotFound
        }
        
        foundTask.title = task.title
        foundTask.taskDescription = task.description
        foundTask.createdAt = task.createdAt
        foundTask.isCompleted = task.isCompleted

        try saveIfNeeded()
    }
}

private extension DailyQuest {
    func toLocal() -> LocalDailyQuest {
        LocalDailyQuest(questId: id, timestamp: timestamp, tasks: tasks.toLocals())
    }
}

private extension DailyTask {
    func toLocal() -> LocalDailyTask {
        LocalDailyTask(taskId: id, title: title, taskDescription: description, createdAt: createdAt, isCompleted: isCompleted)
    }
}

private extension Array where Element == DailyTask {
    func toLocals() -> [LocalDailyTask] {
        map { $0.toLocal() }
    }
}

private extension LocalDailyQuest {
    func toModel() -> DailyQuest {
        DailyQuest(id: questId, timestamp: timestamp, tasks: tasks.toModels())
    }
}

private extension LocalDailyTask {
    func toModel() -> DailyTask {
        DailyTask(id: taskId, title: title, description: taskDescription, createdAt: createdAt, isCompleted: isCompleted)
    }
}

private extension Array where Element == LocalDailyTask {
    func toModels() -> [DailyTask] {
        map { $0.toModel() }
    }
}
