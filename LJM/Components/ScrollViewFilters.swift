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
    var vm: ScrollToModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            ScrollViewReader { (proxy: ScrollViewProxy) in
                LazyHStack {
                    HStack(spacing: 10) {
                        ForEach(filterTabs, id: \.self) { i in
                            
                            Button(action: {
                                selectedFilter = i
                            }) {
                                Text(i.capitalized)
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundColor(selectedFilter == i ? .white : .customDarkGrey)
                                    .frame(width: 150, height: 40)
                                    .background(selectedFilter == i ? Color.customCyan : .white)
                            }.buttonStyle(PlainButtonStyle())
                            .frame(width: 150, height: 40)
                            .background(selectedFilter == i ? Color.customCyan : .white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).foregroundColor(selectedFilter == i ? .clear : .customDarkGrey))
                        }
                    }.padding([.leading, .trailing], 10)
                }.onReceive(vm.$direction) { action in
                    guard !filterTabs.isEmpty else { return }
                    withAnimation {
                        switch action {
                        case .left:
                            proxy.scrollTo(filterTabs.first!, anchor: .leading)
                        case .right:
                            proxy.scrollTo(filterTabs.last!, anchor: .trailing)
                        default:
                            return
                        }
                    }
                }.frame(height: 60)
                .padding(.top, 5).padding(.bottom, 5)
            }
        }
    }
}

