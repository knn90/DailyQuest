//
//  PlusButton.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.10
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import SwiftUI

struct PlusButton: View {

    private let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Circle()
            .fill(Color.action)
            .overlay(content: {
                Image(systemName: "plus")
                    .foregroundColor(Color.inactive)
                    .font(.title.bold())
            })
            .frame(width: 60, height: 60)
            .padding()
            .onTapGesture {
                self.action()
            }
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton {}
    }
}
