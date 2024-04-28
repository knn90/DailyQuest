//
//  TaskView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: Task

    var body: some View {
        HStack(alignment: .checkboxTitleAlignmentGuide) {
            VStack {
                Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                    .alignmentGuide(.checkboxTitleAlignmentGuide) { context in
                        context[.firstTextBaseline]
                }
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(task.title)
                    .font(.headline)
                    .alignmentGuide(.checkboxTitleAlignmentGuide) { context in
                        context[.firstTextBaseline]
                    }
                    .foregroundStyle(task.isCompleted ? .tertiary : .primary)
                Text(task.description)
                    .foregroundStyle(task.isCompleted ? .quaternary : .secondary)
                    .font(.subheadline)
            }
            Spacer()
        }
        .background(.white)
        .animation(.default, value: task.isCompleted)
        .onTapGesture {
            task.isCompleted.toggle()
        }
    }
}

fileprivate extension VerticalAlignment {
    struct CheckboxTitleAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }

    static let checkboxTitleAlignmentGuide = VerticalAlignment(
        CheckboxTitleAlignment.self
    )
}

#Preview {
    TaskView(task: .constant(Task(id: "1", title: "title", description: "description", isCompleted: true)))
}
