//
//  Modifiers.swift
//  LJM
//
//  Created by Tony Tresgots on 11/02/2021.
//

import SwiftUI

struct PaddingMainSubViews: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top, 80)
            .padding([.top, .leading, .trailing], 20)
    }
}
