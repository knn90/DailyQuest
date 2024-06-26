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
        VStack(spacing: 16) {
            TextField("Title", text: $task.title)
                .font(.title2)
                .padding(.horizontal, 4)
                .padding(.vertical, 8)
                .background(.white)
                .cornerRadius(8)
            TextEditor(text: $task.description)
                .cornerRadius(8)
                .frame(maxHeight: 300)
            Button(action: {
            }, label: {
                Image(systemName: "square.and.pencil.circle.fill")
                    .resizable()
            })
            .foregroundColor(.cyan)
            .frame(width: 64, height: 64)
            Spacer()
        }
        .padding()
        .cornerRadius(8)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    TaskDetailsView(task: PresentationTask(id: "", title: "d", description: "description", isCompleted: false))
}
