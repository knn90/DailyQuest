//
//  TaskDetailsView.swift
//  
//
//  Created by Khoi Nguyen on 26/6/24.
//

import SwiftUI

struct TaskDetailsView: View {
    @ObservedObject private var viewModel: TaskDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: TaskDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                Section("Title") {
                    TextField("Title", text: $viewModel.task.title)
                        .font(.title3)
                }
                Section("Description") {
                    TextEditor(text: $viewModel.task.description)
                        .frame(minHeight: 250)
                }
            }
            .scrollDismissesKeyboard(.interactively)

            Button(action: {
                Task {
                    await viewModel.updateTask()
                    dismiss()
                }
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
