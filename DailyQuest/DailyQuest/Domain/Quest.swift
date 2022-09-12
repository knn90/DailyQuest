//
//  Quest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.11
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation

public struct Quest: Equatable {
    let id: UUID
    let title: String
    let isDone: Bool

    public init(id: UUID, title: String, isDone: Bool) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
}
