//
//  AddTaskView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 19/6/24.
//

import SwiftUI

struct AddTaskView: View {
    @Binding private var taskTitle: String
    @FocusState private var isFocused: Bool
    private var isAddingTask: Bool

    init(taskTitle: Binding<String>, isAddingTask: Bool) {
        self._taskTitle = taskTitle
        self.isAddingTask = isAddingTask
    }

    var body: some View {
        TextField("Add task", text: $taskTitle)
            .focused($isFocused)
            .onAppear {
                isFocused = isAddingTask
            }
            .onChange(of: isAddingTask) { _, newValue in
                isFocused = newValue
            }
    }
}

