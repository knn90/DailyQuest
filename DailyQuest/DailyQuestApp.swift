//
//  DailyQuestApp.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import SwiftUI
import QuestLocalStore

@main
struct DailyQuestApp: App {
    var body: some Scene {
        WindowGroup {
            QuestView(viewModel: QuestViewModel(service: LocalQuestService(store: try! SwiftDataQuestStore())))
        }
    }
}
