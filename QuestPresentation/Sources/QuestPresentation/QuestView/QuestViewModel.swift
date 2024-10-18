//
//  QuestViewModel.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation

protocol QuestViewModelDelegate {
    func getDailyTasks() async throws -> [PresentationTask]
    func addTask(title: String) async throws -> PresentationTask
    func toggleTask(_ task: PresentationTask) async throws
}

@MainActor
final class QuestViewModel: ObservableObject {
    @Published var tasks: [PresentationTask] = []
    @Published var isShowingError = false
    @Published var isLoading = false

    private var delegate: QuestViewModelDelegate

    init(delegate: QuestViewModelDelegate) {
        self.delegate = delegate
    }

    func getDailyQuest() async {
        isLoading = true
        do {
            tasks = try await delegate.getDailyTasks()
        } catch {
            isShowingError = true
        }

        isLoading = false
    }

    func addTask(title: String) async {
        do {
            let task = try await delegate.addTask(title: title)
            tasks.append(task)
        } catch {
            isShowingError = true
        }
    }

    func toggleTask(_ task: PresentationTask) async {
        do {
            try await delegate.toggleTask(task)
        } catch {
            isShowingError = true
        }
    }
}
