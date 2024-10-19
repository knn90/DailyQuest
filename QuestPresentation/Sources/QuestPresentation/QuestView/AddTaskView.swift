//
//  AddTaskView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 19/6/24.
//

import SwiftUI

struct AddTaskView: View {
    @State private var taskTitle = ""
    private let completion: (String) -> Void

    init(completion: @escaping (String) -> Void) {
        self.completion = completion
    }

    var body: some View {
        TextField("Add task", text: $taskTitle)
            .onSubmit {
                completion(taskTitle)
                taskTitle = ""
            }
    }
}

