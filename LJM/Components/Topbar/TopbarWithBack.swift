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
    
    var filters: Dictionary<String, Array<String>>
    @Binding var scrollTarget: Bool
    @Binding var toggleFilters: Bool
    @Binding var isFilterShown : Bool
    
    @Binding var isViewSelected : Bool
    
    var body: some View {
        VStack {
            if #available(macOS 12.0, *) {
                    HStack {
                        Button {
                            title = ""
                            isViewSelected = false
                        } label: {
                            HStack{
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 10))
                                    .padding(.leading, 20)
                                Text("Back")
                            }
                            .padding(.leading, 20)
                            .background {
                                Color.gray.opacity(0.001)
                            }
                           
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(minWidth: 200, maxWidth: 300, alignment: .leading)
                        
                        
                        Spacer()
                        
                        Text(title ?? "")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .frame(width: 600, alignment: .center)
                        
                        Spacer()
                        
                        
                        Button {
                            // scroll view index to 1
                            scrollTarget.toggle()
                            toggleFilters = true
                        } label: {
                            HStack {
                                
                                Text("Filters \(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count == nil || getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count == 0 ? "" : "(\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count != 1 ? ("\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count)") : "\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).first ?? "")"))")")
                                
                                Image(systemName: "chevron.up")
                                    .font(.system(size: 10))
                            }.padding(.trailing, 20)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 20)
                        .frame(minWidth: 200, maxWidth: 300, alignment: .trailing)
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
                    .background (Color.gray.opacity(0.00001))
                    
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
                            
                            Text("Filters \(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count == nil || getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count == 0 ? "" : "(\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count != 1 ? ("\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count)") : "\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).first ?? "")"))")")
                            
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
    
    func getNumberOfFilters(filters: Dictionary<String, Array<String>>) -> [String] {
        
        let values = filters.map {$0.value}
        var arrayValues = [String]()
        
        for value in values {
            arrayValues.append(contentsOf: value)
        }
                
        return arrayValues
    }

}
