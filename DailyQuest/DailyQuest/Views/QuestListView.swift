//
//  QuestListView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.10
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import SwiftUI

struct QuestListView: View {
    private var quests: Binding<[QuestViewModel]>

    init(quests: Binding<[QuestViewModel]>) {
        self.quests = quests
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(quests, id: \.self) { quest in
                    QuestView(quest: quest.wrappedValue)
                }
            }
            .background(Color.gainsboro)
        }
    }
}

struct QuestListView_Previews: PreviewProvider {
    static var previews: some View {
        QuestListView(quests: Binding.constant([
            QuestViewModel(title: "Do something", isDone: false),
            QuestViewModel(title: "Do another thing", isDone: true),
            QuestViewModel(title: "Do 1 something", isDone: false),
            QuestViewModel(title: "Do 2 another thing", isDone: true),
            QuestViewModel(title: "Do 3 something", isDone: false),
            QuestViewModel(title: "Do 4 another thing", isDone: true),
            QuestViewModel(title: "Do 5 something", isDone: false),
            QuestViewModel(title: "Do 6 another thing", isDone: true),
            QuestViewModel(title: "Do 7 something", isDone: false),
            QuestViewModel(title: "Do 8 another thing", isDone: true),
            QuestViewModel(title: "Do a quest with super long description so it can't be display in one line. But it's 3 lines", isDone: true),
        ]))
    }
}
