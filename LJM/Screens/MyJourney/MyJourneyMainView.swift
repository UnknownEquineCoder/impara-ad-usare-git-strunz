//
//  MyJourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 20/04/2021.
//

import SwiftUI

struct MyJourneyMainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showSearchBarSideBar = true
    
    @Binding var selectedMenu: OutlineMenu
            
    var body: some View {
        ZStack(alignment: .top) {
            MyJourneyView(selectedMenu: $selectedMenu)
                .modifier(PaddingMainSubViews())
            
        }
        .background(Color.clear)
    }
}
