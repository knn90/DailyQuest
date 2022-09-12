//
//  DailyQuestViewUIComposer.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.12
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import Foundation
import SwiftUI

final class DailyQuestViewUIComposer {
    static func compose() -> DailyQuestView {
        return DailyQuestView(viewModel: DailyQuestViewModelFactory.make())
    }
}
