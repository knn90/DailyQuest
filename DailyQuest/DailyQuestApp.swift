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
    var body: some Scene {
        WindowGroup {
            QuestViewComposer.compose(service: try! LocalQuestService())
        }
    }
}
