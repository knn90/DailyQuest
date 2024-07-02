//
//  TaskService.swift
//
//
//  Created by Khoi Nguyen on 2/7/24.
//

import Foundation

public protocol TaskService {
    func updateTask(_ task: DailyTask) async throws
}
