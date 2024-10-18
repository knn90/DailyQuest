//
//  DailyQuestApp.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import SwiftUI
import QuestLocalStore
import QuestPresentation

@main
struct DailyQuestApp: App {
    private let store = try! SwiftDataQuestStore()
    var body: some Scene {
        WindowGroup {
            QuestViewComposer.compose(questService: LocalQuestService(store: store), taskService: LocalTaskService(store: store))
        }
    }
}
