//
//  CheckMarkView.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 2022.09.10
//  Copyright © 2022 Swedebeat AB. All rights reserved.
//

import SwiftUI

struct CheckMarkView: View {
    @Binding var isChecked: Bool
    var body: some View {
        if isChecked {
            Rectangle()
                .fill(Color.action)
                .frame(width: 25, height: 25)
                .padding()
                .overlay(Image(systemName: "checkmark")
                    .foregroundColor(Color.inactive))
        } else {
            Rectangle()
                .fill(Color.background)
                .border(Color.action, width: 1)
                .frame(width: 25, height: 25)
                .padding()
        }
    }
}

struct CheckMarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckMarkView(isChecked: .constant(true))
    }
}
