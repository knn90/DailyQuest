//
//  DailyQuestView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.10
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import SwiftUI

struct DailyQuestView: View {

    @State private var isAddingQuest: Bool = false

    @ObservedObject private var viewModel: DailyQuestViewModel

    init(quests: [QuestViewModel]) {
        self.viewModel = DailyQuestViewModel(quests: quests)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if isAddingQuest {
                    NewQuestView(onSubmit: { title in
                        withAnimation {
                            let addedQuest = QuestViewModel(title: title, isDone: false)
                            self.viewModel.add(addedQuest)
                            self.isAddingQuest.toggle()
                        }
                    })
                }
                QuestListView(quests: viewModel.quests)
            }
            .padding()

            PlusButton {
                withAnimation {
                    self.isAddingQuest.toggle()
                }
            }
            .rotationEffect(Angle(degrees: isAddingQuest ? 45 : 0))
            .padding(.bottom, 20)
        }
        .background(Color.background)
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
