//
//  QuestRepository.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 10/5/24.
//

import Foundation
import SwiftData

@Model
final class LocalDailyQuest {
    @Attribute(.unique) 
    var id: String
    @Attribute(.unique) 
    var timestamp: String
    @Relationship(deleteRule: .cascade, inverse: \LocalDailyTask.quest)
    var tasks: [LocalDailyTask]


    init(id: String, timestamp: String, tasks: [LocalDailyTask]) {
        self.id = id
        self.timestamp = timestamp
        self.tasks = tasks
    }
}

@Model
final class LocalDailyTask {
    @Attribute(.unique) var id: String
    var title: String
    var taskDescription: String
    var createdAt: Date
    var isCompleted: Bool
    var quest: LocalDailyQuest?

    init(id: String, title: String, taskDescription: String, createdAt: Date, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}

protocol QuestStore {
    func retrieve(for date: String) throws -> DailyQuest?
    func insert(quest: DailyQuest) throws
    func update(quest: DailyQuest) throws
}

final class SwiftDataQuestStore {
    private let container: ModelContainer
    private let context: ModelContext

    enum Error: Swift.Error {
        case questNotFound
    }

    init(inMemoryOnly: Bool = false) throws {
        let schema = Schema([LocalDailyQuest.self, LocalDailyTask.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        self.container = try ModelContainer(for: schema, configurations: config)
        self.context = ModelContext(container)
    }

    func retrieve(for date: String) throws -> DailyQuest? {
        let predicate = #Predicate<LocalDailyQuest> {
            $0.timestamp == date
        }

        let fetchDescriptor = FetchDescriptor<LocalDailyQuest>(predicate: predicate)
        let localQuest = try context.fetch(fetchDescriptor).first
        return localQuest?.toModel()
    }

    func insert(quest: DailyQuest) throws {
        context.insert(quest.toLocal())
        try context.save()
    }

    func update(quest: DailyQuest) throws {
        let timestamp = quest.timestamp
        let predicate = #Predicate<LocalDailyQuest> {
            $0.timestamp == timestamp
        }

        let fetchDescriptor = FetchDescriptor<LocalDailyQuest>(predicate: predicate)
        guard let oldQuest = try context.fetch(fetchDescriptor).first else {
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
