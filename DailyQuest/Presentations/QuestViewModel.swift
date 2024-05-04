//
//  QuestViewModel.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 28/4/24.
//

import Foundation
protocol QuestService {
    func getDailyQuest()
}

final class QuestViewModel: ObservableObject {
    @Published var tasks: [Task] = [
        Task(id: "1", title: "Short task", description: "short description", isCompleted: false),
        Task(id: "2", title: "Second short task", description: "do something really long long long long time. It's not enought. It's should be longer", isCompleted: false),
        Task(id: "3", title: "Long task", description: "Not so long description", isCompleted: false),
        Task(id: "4", title: "Super long long long long long long long task", description: "do something really long long long long time. It's not enought. It's should be longer", isCompleted: false)
    ]

    private let service: QuestService

    init(service: QuestService) {
        self.service = service
    }

    func getDailyQuest() {
        service.getDailyQuest()
    }
}

