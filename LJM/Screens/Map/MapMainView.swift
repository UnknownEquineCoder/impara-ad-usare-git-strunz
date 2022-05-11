//
//  JourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import Foundation
import SwiftUI

struct MapMainView: View {
    
    @State private var offset = CGFloat.zero
    @State private var scrollTarget: Bool = false
    @State private var toggleFilters: Bool = false
    @State private var selectedFilters: Dictionary<String, Array<String>> = [:]

    @Environment(\.colorScheme) var colorScheme
            
    var body: some View {
        ZStack(alignment: .top) {
            MapView(offset: $offset, scrollTarget: $scrollTarget, selectedFilters: $selectedFilters, toggleFilters: $toggleFilters)
                .modifier(PaddingMainSubViews())
            
            if(toggleFilters ? offset > 475 : offset > 200) {
                Topbar(title: "Map", filters: selectedFilters, scrollTarget: $scrollTarget, toggleFilters: $toggleFilters)
            }
        }
    }
}
