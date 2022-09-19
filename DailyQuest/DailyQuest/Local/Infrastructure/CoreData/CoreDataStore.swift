//
//  CoreDataStore.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.19
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import CoreData

public final class CoreDataStore: DailyQuestStore {
    static private let modelName = "DailyQuestDataModel"
    static private let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataStore.self))


    public func load(date: Date) async throws -> LocalDailyQuest? {
        return nil
    }
}

extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        return bundle
            .url(forResource: name, withExtension: "momd")
            .flatMap { NSManagedObjectModel(contentsOf: $0) }
    }
}
