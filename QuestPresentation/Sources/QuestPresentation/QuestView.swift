//
//  QuestView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import SwiftUI
import QuestServices

public struct QuestView: View {
    @ObservedObject private var viewModel: QuestViewModel
    @State private var isAddingTask = false
    @State private var newTask = ""
    @FocusState private var isFocused: Bool

    public init(viewModel: QuestViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
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

final class PreviewQuestService: QuestService {
    func getTodayQuest() -> DailyQuest {
        DailyQuest(
            id: "",
            timestamp: "",
            tasks: [
                DailyTask(id: "1", title: "Short task", description: "short description", createdAt: Date(), isCompleted: false),
                DailyTask(id: "2", title: "Second short task", description: "do something really long long long long time. It's not enought. It's should be longer", createdAt: Date(), isCompleted: false),
                DailyTask(id: "3", title: "Long task", description: "Not so long description", createdAt: Date(), isCompleted: false),
                DailyTask(id: "4", title: "Super long long long long long long long task", description: "do something really long long long long time. It's not enought. It's should be longer", createdAt: Date(), isCompleted: false)
            ]
        )
    }

    func updateQuest(_ quest: DailyQuest) throws {
    }
}
