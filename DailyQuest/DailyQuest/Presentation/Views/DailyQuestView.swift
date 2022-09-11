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

    init(viewModel: DailyQuestViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if isAddingQuest {
                    NewQuestView(onSubmit: { title in
                        withAnimation {
                            let addedQuest = QuestViewModel(id: UUID().uuidString, title: title, isDone: false)
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
        DailyQuestView(viewModel: DailyQuestViewModelFactory.make())
    }
}
