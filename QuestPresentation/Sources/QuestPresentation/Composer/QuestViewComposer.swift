//
//  QuestViewComposer.swift
//
//
//  Created by Khoi Nguyen on 24/6/24.
//

import Foundation
import SwiftUI
import QuestServices

public enum QuestViewComposer {
    @MainActor
    public static func compose(questService: QuestService, taskService: TaskService) -> some View {
        let delegate = QuestViewAdapter(questService: questService, taskService: taskService)
        let viewModel = QuestViewModel(delegate: delegate)
        let taskDetailsViewAdapter = TaskDetailsViewAdapter(taskService: taskService)
        return QuestView(viewModel: viewModel, taskDetailsViewModelDelegate: taskDetailsViewAdapter)
    }
}

final class QuestViewAdapter: QuestViewModelDelegate {
    let questService: QuestService
    let taskService: TaskService
    
    init(questService: QuestService, taskService: TaskService) {
        self.questService = questService
        self.taskService = taskService
    }

    func getDailyTasks() async throws -> [PresentationTask] {
        let quest = try await questService.getQuest(date: Date())

        return quest.tasks.map { $0.toPresentationModel() }
    }

    func addTask(title: String) async throws -> PresentationTask {
        let task = try await questService.addTask(title: title)
        
        return task.toPresentationModel()
    }

    func toggleTask(_ task: PresentationTask) async throws {
        try await taskService.updateTask(task.toModel())
    }
}

final class TaskDetailsViewAdapter: TaskDetailsViewModelDelegate {
    let taskService: TaskService
    
    init(taskService: TaskService) {
        self.taskService = taskService
    }
    
    func updateTask(_ task: PresentationTask) async throws {
        try await taskService.updateTask(task.toModel())
    }
}

private extension DailyTask {
    func toPresentationModel() -> PresentationTask {
        PresentationTask(id: id, title: title, description: description, createdAt: createdAt, isCompleted: isCompleted)
    }
}

private extension PresentationTask {
    func toModel() -> DailyTask {
        DailyTask(id: id, title: title, description: description, createdAt: createdAt, isCompleted: isCompleted)
    }
}
