//
//  NewQuestView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.10
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import SwiftUI

struct NewQuestView: View {
    @State private var newQuestTitle: String = ""
    
    var body: some View {
        TextField("New quest", text: $newQuestTitle)
            .padding()
            .border(Color.glaucous, width: 1)
            .background(Color.gainsboro)
            .cornerRadius(3)
    }
}

struct NewQuestView_Previews: PreviewProvider {
    static var previews: some View {
        NewQuestView()
    }
}
