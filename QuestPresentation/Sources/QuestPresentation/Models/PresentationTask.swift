//
//  PresentationTask.swift
//  
//
//  Created by Khoi Nguyen on 24/6/24.
//

import Foundation

struct PresentationTask: Identifiable, Hashable {
    let id: String
    var title: String
    var description: String
    let createdAt: Date
    var isCompleted: Bool

    init(id: String, title: String, description: String, createdAt: Date, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.createdAt = createdAt
        self.isCompleted = isCompleted
    }
}
