//
//  ContextMenuTest.swift
//  LJM
//
//  Created by Laura Benetti on 18/10/21.
//

import Foundation
import SwiftUI

struct ContextMenuFilters: View {
    
    var fromMap = false
    
    @Binding var selectedFilter: CoreEnum.RawValue
    @Binding var selectedPath : String?
    @Binding var selectedStrands : [String]
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var strandsStore: StrandsStore
    
    var body: some View {
        Menu {
            Menu("View") {
                Button("Full Map", action: {selectedFilter = "FULL MAP"})
                Button("Communal", action: {selectedFilter = "COMMUNAL"})
                Button("Elective", action: {selectedFilter = "ELECTIVE"})
            }
            
            Menu("Paths") {
                Button("UI/UX", action: {
                    print("IOJHUYGH \(self.strandsStore.arrayStrandsNativeFilter)")
                    if self.fromMap {
                        selectedFilter = "UI/UX"
                    } else {
                        selectedPath = "UI/UX"
                    }
                })
                
                Button("Frontend", action: {
                    if self.fromMap {
                        selectedFilter = "Front"
                    } else {
                        selectedPath = "Front"
                    }
                })
                
                Button("Backend", action: {
                    if self.fromMap {
                        selectedFilter = "Back"
                    } else {
                        selectedPath = "Back"
                    }
                })
                
                Button("Game", action: {
                    if self.fromMap {
                        selectedFilter = "Game"
                    } else {
                        selectedPath = "Game"
                    }
                })
                
                Button("Business", action: {
                    if self.fromMap {
                        selectedFilter = "Business"
                    } else {
                        selectedPath = "Business"
                    }
                })
            }
            
            Menu("Strands") {
                ForEach(self.strandsStore.arrayStrandsNativeFilter, id: \.self) { strand in
                    Button {
                        if !self.selectedStrands.contains(strand) {
                            self.selectedStrands.append(strand)
                        } else {
                            self.selectedStrands.remove(object: strand)
                        }
                    } label: {
                        HStack {
                            Text(strand)
                            Image(systemName: "checkmark")
                                .isHidden(!self.selectedStrands.contains(strand))
                        }
                    }
                }
                
            }
        } label: {
            HStack(spacing: 13) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                //                    .resizable()
                //                    .frame(width: 10, height: 10)
                    .foregroundColor(colorScheme == .dark ? Color(red: 160/255, green: 159/255, blue: 159/255) : Color(red: 87/255, green: 87/255, blue: 87/255))
                
                Text("Filters")
                //                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? Color(red: 160/255, green: 159/255, blue: 159/255) : Color(red: 87/255, green: 87/255, blue: 87/255))
            }
            
        }
        .frame(width: 132.toScreenSize(), height: 35.toScreenSize(), alignment: .center)
        //        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
        //        .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .red)
        .menuStyle(BorderedButtonMenuStyle())
        
    }
    
}

struct ContextMenuTest_Previews: PreviewProvider {
    
    static var previews: some View {
        ContextMenuFilters(selectedFilter: .constant("CORE"), selectedPath: .constant(""), selectedStrands: .constant([""]))
    }
}



