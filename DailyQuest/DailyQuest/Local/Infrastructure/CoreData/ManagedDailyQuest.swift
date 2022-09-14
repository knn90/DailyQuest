//
//  ManagedDailyQuest.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.14
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation
import CoreData

@objc(ManagedDailyQuest)
class ManagedDailyQuest: NSManagedObject {

    @NSManaged var id: UUID
    @NSManaged var createAt: Date
    @NSManaged var doneAt: Date?
    @NSManaged var quests: NSOrderedSet

}
