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
                .fill(Color.glaucous)
                .frame(width: 25, height: 25)
                .padding()
                .overlay(Image(systemName: "checkmark")
                    .foregroundColor(Color.gainsboro))
        } else {
            Rectangle()
                .fill(Color.gainsboro)
                .border(Color.glaucous, width: 1)
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
