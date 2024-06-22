//
//  QuestRepository.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 10/5/24.
//

import Foundation
import SwiftData
import QuestServices

public final class SwiftDataQuestStore: QuestStore {
    private let container: ModelContainer
    private let context: ModelContext

    public enum Error: Swift.Error {
        case questNotFound
    }

    public init(inMemoryOnly: Bool = false) throws {
        let schema = Schema([LocalDailyQuest.self, LocalDailyTask.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        self.container = try ModelContainer(for: schema, configurations: config)
        self.context = ModelContext(container)
    }

    public func retrieve(for date: String) throws -> DailyQuest? {
        let localQuest = try context
            .fetch(LocalDailyQuest.fetchDescriptor(timestamp: date))
            .first

        return localQuest?.toModel()
    }

    public func insert(quest: DailyQuest) throws {
        context.insert(quest.toLocal())
        try context.save()
    }

    public func update(quest: DailyQuest) throws {
        guard let oldQuest = try context.fetch(LocalDailyQuest.fetchDescriptor(timestamp: quest.timestamp)).first else {
            throw Error.questNotFound
        }

        oldQuest.id = quest.id
        oldQuest.timestamp = quest.timestamp
        oldQuest.tasks = quest.tasks.toLocals()
        try context.save()
    }
}

private extension DailyQuest {
    func toLocal() -> LocalDailyQuest {
        LocalDailyQuest(id: id, timestamp: timestamp, tasks: tasks.toLocals())
    }
}

private extension DailyTask {
    func toLocal() -> LocalDailyTask {
        LocalDailyTask(id: id, title: title, taskDescription: description, createdAt: createdAt, isCompleted: isCompleted)
    }
}

private extension Array where Element == DailyTask {
    func toLocals() -> [LocalDailyTask] {
        map { $0.toLocal() }
    }
}

private extension LocalDailyQuest {
    func toModel() -> DailyQuest {
        DailyQuest(id: id, timestamp: timestamp, tasks: tasks.toModels())
    }
}

private extension LocalDailyTask {
    func toModel() -> DailyTask {
        DailyTask(id: id, title: title, description: taskDescription, createdAt: createdAt, isCompleted: isCompleted)
    }
}

private extension Array where Element == LocalDailyTask {
    func toModels() -> [DailyTask] {
        map { $0.toModel() }
    }
}
