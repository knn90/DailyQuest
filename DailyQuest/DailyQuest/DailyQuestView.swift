//
//  DailyQuestView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.10
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import SwiftUI

struct DailyQuestView: View {

    @State private var quests: [QuestViewModel]
    @State private var isAddingQuest: Bool = false
    
    init(quests: [QuestViewModel]) {
        self.quests = quests
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack {
                    LazyVStack(spacing: 8) {
                        if isAddingQuest {
                            NewQuestView(onSubmit: { title in
                                let addedQuest = QuestViewModel(title: title, isDone: false)
                                quests.insert(addedQuest, at: 0)
                                self.isAddingQuest.toggle()
                            })
                        }
                        ForEach(quests, id: \.self) { quest in
                            QuestView(quest: quest)
                        }
                    }
                    .background(Color.gainsboro)
                    .padding()
                }
            }

            PlusButton {
                self.isAddingQuest.toggle()
            }
        }
    }
}

struct DailyQuestView_Previews: PreviewProvider {
    static var previews: some View {
        DailyQuestView(quests: [
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
        ])
    }
}
