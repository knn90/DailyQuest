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
    public static func compose(service: QuestService) -> some View {
        let delegate = QuestViewAdapter(service: service)
        let viewModel = QuestViewModel(delegate: delegate)
        return QuestView(viewModel: viewModel)
    }
}

final class QuestViewAdapter: QuestViewModelDelegate {
    let service: QuestService

    init(service: QuestService) {
        self.service = service
    }

    func getDailyTasks() async throws -> [PresentationTask] {
        let quest = try await service.getQuest(date: Date())

        return quest.tasks.map { $0.toPresentationModel() }
    }

    func addTask(title: String) async throws -> PresentationTask {
        let task = try await service.addTask(title: title)
        
        return task.toPresentationModel()
    }
}

private extension DailyTask {
    func toPresentationModel() -> PresentationTask {
        PresentationTask(id: id, title: title, description: description, isCompleted: isCompleted)
    }
}
