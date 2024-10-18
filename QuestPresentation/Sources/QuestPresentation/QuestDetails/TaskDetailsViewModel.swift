//
//  TaskDetailsViewModel.swift
//
//
//  Created by Khoi Nguyen on 18/10/24.
//

import Foundation

protocol TaskDetailsViewModelDelegate: AnyObject {
    func updateTask(_ task: PresentationTask) async throws
}

final class TaskDetailsViewModel: ObservableObject {
    @Published var task: PresentationTask
    private let delegate: TaskDetailsViewModelDelegate?
    
    init(task: PresentationTask, delegate: TaskDetailsViewModelDelegate) {
        self.task = task
        self.delegate = delegate
    }
    
    func updateTask() async {
        do {
            try await delegate?.updateTask(task)
        } catch {
            
        }
    }
}
