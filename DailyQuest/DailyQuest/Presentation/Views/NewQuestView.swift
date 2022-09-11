//
//  NewQuestView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.10
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import SwiftUI

struct NewQuestView: View {

    @State private var questTitle: String = ""

    private let onSubmit: (String) -> Void

    init(onSubmit: @escaping (String) -> Void) {
        self.onSubmit = onSubmit
    }

    var body: some View {
        TextField("New quest", text: $questTitle)
            .padding()
            .border(Color.action, width: 2)
            .background(Color.background)
            .cornerRadius(3)
            .onSubmit({
                self.onSubmit(questTitle)
            })
    }
}

struct NewQuestView_Previews: PreviewProvider {
    static var previews: some View {
        NewQuestView(onSubmit: { _ in })
    }
}
