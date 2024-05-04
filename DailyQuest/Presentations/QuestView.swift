//
//  QuestView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import SwiftUI

struct QuestView: View {
    
    @ObservedObject private var viewModel: QuestViewModel

    init(viewModel: QuestViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List($viewModel.tasks) { task in
            TaskView(task: task)
        }
    }
}

#Preview {
    QuestView(viewModel: QuestViewModel(service: PreviewQuestService()))
}
