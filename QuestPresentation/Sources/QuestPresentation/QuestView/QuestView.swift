//
//  QuestView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import SwiftUI

public struct QuestView: View {
    @ObservedObject private var viewModel: QuestViewModel
    @State private var isAddingTask = false
    @State private var path = NavigationPath()
    @Namespace var topID

    init(viewModel: QuestViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                taskListView
                PlusButton(isAddingTask: $isAddingTask)
            }
            .navigationTitle("Today Quest")
            .scrollDismissesKeyboard(.interactively)
            .navigationDestination(for: PresentationTask.self) {  task in
                TaskDetailsView(task: task)
            }
        }
    }

    private var addTaskView: some View {
        Section {
            AddTaskView(isAddingTask: $isAddingTask, viewModel: viewModel)
        }
        .id(topID)
    }

    private var taskListView: some View {
        ScrollViewReader { proxy in
            List {
                if isAddingTask {
                    addTaskView
                }
                ForEach($viewModel.tasks) { task in
                    TaskView(task: task)
                        .onTapGesture {
                            path.append(task.wrappedValue)
                        }
                        .listRowInsets(EdgeInsets())
                }
            }.task {
                await viewModel.getDailyQuest()
            }
            .onChange(of: isAddingTask) {
                if isAddingTask {
                    proxy.scrollTo(topID)
                }
            }
        }
    }
}

#Preview {
    QuestView(viewModel: QuestViewModel(delegate: PreviewQuestViewDelegate()))
}

private final class PreviewQuestViewDelegate: QuestViewModelDelegate {
    func getDailyTasks() async throws -> [PresentationTask] {
        [
            PresentationTask(id: "1", title: "Short task", description: "short description", isCompleted: false),
            PresentationTask(id: "2", title: "Second short task", description: "do something really long long long long time. It's not enought. It's should be longer", isCompleted: false),
            PresentationTask(id: "3", title: "Long task", description: "Not so long description", isCompleted: false),
            PresentationTask(id: "4", title: "Super long long long long long long long task", description: "do something really long long long long time. It's not enought. It's should be longer", isCompleted: false)
        ]
    }

    func addTask(title: String) throws -> PresentationTask {
        PresentationTask(id: UUID().uuidString, title: "New Added Task", description: "", isCompleted: false)
    }
}
