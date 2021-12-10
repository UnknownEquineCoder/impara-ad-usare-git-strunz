//
//  ScrollViewFilters.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct ScrollViewFilters : View {
    
    var filterTabs: [String]
    @Binding var selectedFilter : String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            ScrollViewReader { (proxy: ScrollViewProxy) in
                LazyHStack {
                    HStack(spacing: 10) {
                        ForEach(filterTabs, id: \.self) { i in
                            
                            Button(action: {
                                selectedFilter = i
                            }) {
                                Text(i.uppercased())
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundColor(selectedFilter == i ? .white : .customDarkGrey)
                                    .frame(width: 150, height: 40)
                                    .background(selectedFilter == i ? Color.customCyan : colorScheme == .dark ? Color.darkThemeBackgroundColor : .white)
                            }.buttonStyle(PlainButtonStyle())
                            .frame(width: 150, height: 40)
                            .background(selectedFilter == i ? Color.customCyan : colorScheme == .dark ? .white : Color.darkThemeBackgroundColor)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).foregroundColor(selectedFilter == i ? .clear : .customDarkGrey))
                        }
                    }.padding([.leading, .trailing], 10)
                }
                .frame(height: 60)
                .padding(.top, 5).padding(.bottom, 5)
            }
        }
    }
}

