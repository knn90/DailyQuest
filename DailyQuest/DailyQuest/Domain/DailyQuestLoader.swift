//
//  DailyQuestLoader.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.12
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

public final class DailyQuestLoader {
    private let store: DailyQuestStore

    public init(store: DailyQuestStore) {
        self.store = store
    }

    public func load(date: Date) async throws -> DailyQuest? {
        let local = try await store.load(date: date)

        return local?.toDomain()
    }
}
