//
//  LocalQuest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.12
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

public struct LocalQuest {
    public let id: UUID
    public let title: String
    public let isDone: Bool

    public init(id: UUID, title: String, isDone: Bool) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
}

extension LocalQuest {
    public func toDomain() -> Quest {
        Quest(id: id, title: title, isDone: isDone)
    }
}
