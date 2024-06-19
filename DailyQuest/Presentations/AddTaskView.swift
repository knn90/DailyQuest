//
//  AddTaskView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 19/6/24.
//

import SwiftUI

struct AddTaskView: View {
    @Binding private var taskTitle: String
    @Binding private var isAddingTask: Bool
    @FocusState private var isFocused: Bool

    init(taskTitle: Binding<String>, isAddingTask: Binding<Bool>) {
        self._taskTitle = taskTitle
        self._isAddingTask = isAddingTask
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
