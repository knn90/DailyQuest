//
//  ManagedQuest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.14
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation
import CoreData

@objc(ManagedQuest)
class ManagedQuest: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var title: String
    @NSManaged var isDone: Bool
}
