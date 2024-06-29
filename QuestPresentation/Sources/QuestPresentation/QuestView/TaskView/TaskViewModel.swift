//
//  TaskViewModel.swift
//
//
//  Created by Khoi Nguyen on 27/6/24.
//

import Foundation

protocol TaskViewModelDelegate {
    func updateTask(_ task: PresentationTask)
}

final class TaskViewModel: ObservableObject {
    @Published var task: PresentationTask
    private let delegate: TaskViewModelDelegate

    init(task: PresentationTask, delegate: TaskViewModelDelegate) {
        self.task = task
        self.delegate = delegate
    }

    func updateTask(_ task: PresentationTask) {
        delegate.updateTask(task)
    }
}
