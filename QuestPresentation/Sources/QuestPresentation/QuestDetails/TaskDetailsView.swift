//
//  TaskDetailsView.swift
//  
//
//  Created by Khoi Nguyen on 26/6/24.
//

import SwiftUI

struct TaskDetailsView: View {
    @State private var task: PresentationTask

    init(task: PresentationTask) {
        self.task = task
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                Section("Title") {
                    TextField("Title", text: $task.title)
                        .font(.title3)
                }
                Section("Description") {
                    TextEditor(text: $task.description)
                        .frame(minHeight: 250)
                }
            }
            .scrollDismissesKeyboard(.interactively)

            Button(action: {
            }, label: {
                Image(systemName: "square.and.pencil.circle.fill")
                    .resizable()
            })
            .foregroundColor(.cyan)
            .frame(width: 64, height: 64)
            .padding(.bottom, 24)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TaskDetailsView(task: PresentationTask(id: "", title: "d", description: "description", isCompleted: false))
}
