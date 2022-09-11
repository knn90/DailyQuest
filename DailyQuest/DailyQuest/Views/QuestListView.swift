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
                ForEach(quests, id: \.self) { quest in
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
            QuestViewModel(title: "Do something", isDone: false),
            QuestViewModel(title: "Do another thing", isDone: true),
            QuestViewModel(title: "Do 1 something", isDone: false)
        ])
    }
}
