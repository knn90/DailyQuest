//
//  PlusButton.swift
//  DailyQuest
//
//  Created by Khoi Nguyen on 19/6/24.
//

import Foundation
import SwiftUI

struct PlusButton: View {
    
    @Binding private var isAddingTask: Bool

    init(isAddingTask: Binding<Bool>) {
        self._isAddingTask = isAddingTask
    }

    var body: some View {
        Button(action: {
            isAddingTask.toggle()
        }, label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
        })
        .foregroundColor(.cyan)
        .frame(width: 64, height: 64)
        .rotationEffect(Angle(degrees: isAddingTask ? 45 : 0))
        .animation(.default, value: isAddingTask)
        .padding(.bottom, 24)
    }
}
