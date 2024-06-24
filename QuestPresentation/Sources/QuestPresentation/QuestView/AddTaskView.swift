//
//  AddTaskView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 19/6/24.
//

import SwiftUI

struct AddTaskView: View {
    @State private var taskTitle = ""
    @Binding private var isAddingTask: Bool
    @FocusState private var isFocused: Bool

    private let viewModel: QuestViewModel

    init(isAddingTask: Binding<Bool>, viewModel: QuestViewModel) {
        self._isAddingTask = isAddingTask
        self.viewModel = viewModel
    }

    var body: some View {
        TextField("Add task", text: $taskTitle)
            .focused($isFocused)
            .onAppear {
                isFocused = isAddingTask
            }
            .onDisappear {
                taskTitle = ""
            }
            .onChange(of: isAddingTask) { _, newValue in
                isFocused = newValue
            }
            .onSubmit {
                Task {
                    await viewModel.addTask(title: taskTitle)
                    isAddingTask = false
                }
            }
    }
}

