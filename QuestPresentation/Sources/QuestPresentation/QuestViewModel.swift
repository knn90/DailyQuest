//
//  QuestViewModel.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation
import QuestServices

@MainActor
public final class QuestViewModel: ObservableObject {
    @Published var tasks: [PresentationTask] = []
    @Published var isShowingError = false
    @Published var isLoading = false

    private let service: QuestService

    public init(service: QuestService) {
        self.service = service
    }

    func getDailyQuest() {
        isLoading = true
        do {
//            tasks = try service.getTodayQuest().tasks
        } catch {
            isShowingError = true
        }

        isLoading = false
    }
}

struct PresentationTask: Identifiable {
    let id: String
    var title: String
    var description: String
    var isCompleted: Bool

    init(id: String, title: String, description: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
}
