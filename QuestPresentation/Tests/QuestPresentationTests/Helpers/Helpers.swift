//
//  Helpers.swift
//  DailyQuestTests
//
//  Created by Khoi Nguyen on 8/5/24.
//

import Foundation
@testable import QuestPresentation

func uniqueTask() -> PresentationTask {
    PresentationTask(
        id: UUID().uuidString,
        title: "unique title",
        description: "unique description", 
        createdAt: Date(),
        isCompleted: false)
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: -10010, userInfo: nil)
}
