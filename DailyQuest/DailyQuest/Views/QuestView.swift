//
//  QuestView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.10
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import SwiftUI

struct QuestViewModel: Hashable {
    let title: String
    var isDone: Bool
}

struct QuestView: View {

    @State private var quest: QuestViewModel

    init(quest: QuestViewModel) {
        self.quest = quest
    }

    var body: some View {
        HStack {
            Text(quest.title)
                .strikethrough(quest.isDone)
                .padding()
            Spacer()
            CheckMarkView(isChecked: $quest.isDone)
        }
        .onTapGesture {
            withAnimation {
                self.quest.isDone.toggle()
            }
        }
        .background(quest.isDone ? Color.gainsboro : Color.lightSteelBlue)
        .cornerRadius(3)

    }
}

struct QuestView_Previews: PreviewProvider {
    static var previews: some View {
        QuestView(quest: QuestViewModel(title: "Do something", isDone: true))
    }
}
