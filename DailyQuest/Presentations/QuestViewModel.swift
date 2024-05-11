//
//  QuestViewModel.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation

@MainActor
final class QuestViewModel: ObservableObject {
    @Published var tasks: [DailyTask] = []
    @Published var isShowingError = false
    @Published var isLoading = false

    private let service: QuestService

    init(service: QuestService) {
        self.service = service
    }

    func getDailyQuest() async {
        isLoading = true
        do {
            tasks = try await service.getTodayQuest()
        } catch {
            isShowingError = true
        }

        isLoading = false
    }
}

