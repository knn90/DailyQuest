//
//  QuestViewModel.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation

protocol QuestViewModelDelegate {
    func getDailyTasks() async throws -> [PresentationTask]
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
}