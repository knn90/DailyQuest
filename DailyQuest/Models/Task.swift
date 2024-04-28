//
//  Task.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 17/02/2024.
//

import Foundation

struct Task: Identifiable{
    let id: String
    var title: String
    var description: String
    var isCompleted: Bool
}
