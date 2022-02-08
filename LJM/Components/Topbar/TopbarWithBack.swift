//
//  Topbar.swift
//  LJM
//
//  Created by Tony Tresgots on 20/12/2021.
//

import AppKit
import SwiftUI

struct TopbarWithBack: View {
    var title: String
    @Binding var isButtonPressed: Bool
    
    var filters: Dictionary<String, Array<String>>
    @Binding var scrollTarget: Bool
    @Binding var toggleFilters: Bool
    @Binding var isFiltersShowed: Bool
    
    var body: some View {
        VStack {
            if #available(macOS 12.0, *) {
                    HStack {
                        Button {
                            // scroll view index to 1
                            isButtonPressed.toggle()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 10))
                                .padding(.leading, 20)
                            Text("Back")
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, 20)
                        
                        Spacer()
                        Text(title)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        Spacer()
                        
                        
                        Button {
                            // scroll view index to 1
                            scrollTarget.toggle()
                            toggleFilters = true
                            
                        } label: {
                            HStack {
                                
                                Text("Filters \(getNumberOfFilters(filters: filters))")
                                
                                Image(systemName: "chevron.up")
                                    .font(.system(size: 10))
                            }.padding(.trailing, 20)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 20)
                        .isHidden(!self.toggleFilters)
                        
                    }
                    
                .padding(.vertical, 20)
                .padding(.horizontal, -20)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            } else {
                HStack {
                    Button {
                        // scroll view index to 1
                        isButtonPressed.toggle()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 10))
                            .padding(.leading, 20)
                        Text("Back")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.leading, 20)
                    
                    Spacer()
                    Text(title)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                    Spacer()
                    
                    
                    Button {
                        // scroll view index to 1
                        scrollTarget.toggle()
                        toggleFilters = true
                        
                    } label: {
                        HStack {
                            
                            Text("Filters \(getNumberOfFilters(filters: filters))")
                            
                            Image(systemName: "chevron.up")
                                .font(.system(size: 10))
                        }.padding(.trailing, 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .isHidden(!self.toggleFilters)
                    
                }
                
            .padding(.vertical, 20)
            .padding(.horizontal, -20)
            .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
    }
    
    func getNumberOfFilters(filters: Dictionary<String, Array<String>>) -> String {
        
        let values = filters.map {$0.value}
        var arrayValues = [String]()
        
        for value in values {
            arrayValues.append(contentsOf: value)
        }
                
        if arrayValues.count == 0 {
            return ""
        }
        
        return "(" + String(arrayValues.count) + ")"
        
    }

}