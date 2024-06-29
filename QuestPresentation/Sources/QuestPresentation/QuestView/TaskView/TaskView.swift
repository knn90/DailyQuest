//
//  TaskView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: PresentationTask

    var body: some View {
        HStack() {
            VStack {
                Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                    .frame(width: 32, height: 32)
            }
            .padding(8)
            .onTapGesture {
                task.isCompleted.toggle()
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(task.title)
                    .font(.headline)
                    .foregroundStyle(task.isCompleted ? .tertiary : .primary)
                if !task.description.isEmpty {
                    Text(task.description)
                        .foregroundStyle(task.isCompleted ? .quaternary : .secondary)
                        .font(.subheadline)
                }
            }
            .padding(.vertical, 8)
            Spacer()
        }
        .animation(.default, value: task.isCompleted)
    }
}

#Preview {
    TaskView(task: .constant(PresentationTask(id: "1", title: "title", description: "description", isCompleted: true)))
}
#Preview {
    TaskView(task: .constant(PresentationTask(id: "2", title: "Long long long long long long long long long long long long title", description: "description", isCompleted: true)))
}
