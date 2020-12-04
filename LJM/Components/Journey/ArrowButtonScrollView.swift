//
//  ArrowButtonScrollView.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

func ArrowButtonScrollView(vm: ScrollToModel, direction: ScrollToModel.Action) -> some View {
    return Button(action: {
        withAnimation {
            vm.direction = direction
        }
    }) {
        Image(systemName: direction == .left ? "arrow.left" : "arrow.right")
            .font(.system(size: 15, weight: .semibold, design: .rounded))
            .foregroundColor(Color("customCyan"))
    }
}
