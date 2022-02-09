//
//  Topbar.swift
//  LJM
//
//  Created by Tony Tresgots on 20/12/2021.
//

import AppKit
import SwiftUI

struct TopbarWithBack: View {
    @Binding var title: String?
    
    var filterNumber : Int
    @Binding var scrollTarget: Bool
    @Binding var toggleFilters: Bool
    @Binding var isFilterShown : Bool
    
    var body: some View {
        VStack {
            if #available(macOS 12.0, *) {
                    HStack {
                        Button {
                            title = ""
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 10))
                                .padding(.leading, 20)
                            Text("Back")
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, 20)
                        
                        Spacer()
                        Text(title ?? "")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        Spacer()
                        
                        
                        Button {
                            // scroll view index to 1
                            scrollTarget.toggle()
                            toggleFilters = true
                        } label: {
                            HStack {
                                
                                Text("Filters \(filterNumber > 0 ? "( \(filterNumber) )" : "")")
                                
                                Image(systemName: "chevron.up")
                                    .font(.system(size: 10))
                            }.padding(.trailing, 20)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 20)
                        .isHidden(!self.isFilterShown)
                        
                    }
                .padding(.vertical, 20)
                .padding(.horizontal, -20)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            } else {
                HStack {
                    Button {
                        title = ""
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 10))
                            .padding(.leading, 20)
                        Text("Back")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.leading, 20)
                    
                    Spacer()
                    Text(title ?? "")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                    Spacer()
                    
                    
                    Button {
                        // scroll view index to 1
                        scrollTarget.toggle()
                        toggleFilters = true
                    } label: {
                        HStack {
                            
                            Text("Filters \(filterNumber > 0 ? "( \(filterNumber) )" : "")")
                            
                            Image(systemName: "chevron.up")
                                .font(.system(size: 10))
                        }.padding(.trailing, 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .isHidden(!self.isFilterShown)
                    
                }
                
            .padding(.vertical, 20)
            .padding(.horizontal, -20)
            .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
    }

}
