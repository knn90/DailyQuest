//
//  QuestView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import SwiftUI

struct QuestView: View {
    @ObservedObject private var viewModel: QuestViewModel
    @State private var isAddingTask = false
    @State private var newTask = ""
    @FocusState private var isFocused: Bool

    init(viewModel: QuestViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView(content: {
            ZStack(alignment: .bottom) {
                List {
                    if isAddingTask {
                        addTaskView
                    }
                    ForEach($viewModel.tasks) { task in
                        TaskView(task: task)
                    }
                }.task {
                    viewModel.getDailyQuest()
                }

                PlusButton(isAddingTask: $isAddingTask)
            }
            .navigationTitle("Today Quest")
        })
    }

    private var addTaskView: some View {
        Section {
            AddTaskView(taskTitle: $newTask, isAddingTask: $isAddingTask)
        }
    }
}

#Preview {
    QuestView(viewModel: QuestViewModel(service: PreviewQuestService()))
}
