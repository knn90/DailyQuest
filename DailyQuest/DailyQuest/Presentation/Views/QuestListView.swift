//
//  QuestListView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.10
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import SwiftUI

struct QuestListView: View {
    private var quests: [QuestViewModel]

    init(quests: [QuestViewModel]) {
        self.quests = quests
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(quests) { quest in
                    QuestView(quest: quest)
                }
            }
        }
        .background(Color.background)
    }
}

struct QuestListView_Previews: PreviewProvider {
    static var previews: some View {
        QuestListView(quests: [
            QuestViewModel(id: UUID().uuidString, title: "Do something", isDone: false),
            QuestViewModel(id: UUID().uuidString, title: "Do another thing", isDone: true),
            QuestViewModel(id: UUID().uuidString, title: "Do 1 something", isDone: false)
        ])
    }
}
