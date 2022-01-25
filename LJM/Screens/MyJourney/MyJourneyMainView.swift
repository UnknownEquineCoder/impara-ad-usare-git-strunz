//
//  MyJourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 20/04/2021.
//

import SwiftUI

struct MyJourneyMainView: View {
    
    @State private var offset = CGFloat.zero
    @State private var scrollTarget: Bool = false
    @State private var toggleFilters: Bool = false
    @State private var selectedFilters: Dictionary<String, Array<String>> = [:]
    
    @Environment(\.colorScheme) var colorScheme
        
    @Binding var selectedMenu: OutlineMenu
    
    var body: some View {
        ZStack(alignment: .top) {
            MyJourneyView(offset: $offset, scrollTarget: $scrollTarget, selectedFilters: $selectedFilters, selectedMenu: $selectedMenu, toggleFilters: $toggleFilters)
                .modifier(PaddingMainSubViews())
            
            if(toggleFilters ? offset > 475 : offset > 200) {
                Topbar(title: "Journey", filters: selectedFilters, scrollTarget: $scrollTarget, toggleFilters: $toggleFilters)
            }
        }
        .background(Color.clear)
    }
}
