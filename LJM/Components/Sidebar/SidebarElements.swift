//
//  SidebarElements.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI

enum OutlineMenu: Int, CaseIterable, Identifiable {
    
    var id: Int {
        return self.rawValue
    }
    
    case compass, journey, map
    
    var title: String {
        switch self {
        case .compass:     return "Compass"
        case .journey:     return "Journey"
        case .map:         return "Map"
        }
    }
    
    var image: String {
        switch self {
        case .compass:     return "sidebar_compass"
        case .journey:     return "sidebar_journey"
        case .map:         return "sidebar_map"
        }
    }
}

struct OutlineRow : View {
    let item: OutlineMenu
    @Binding var selectedMenu: OutlineMenu
    
    var isSelected: Bool {
        selectedMenu == item
    }
    
    var body: some View {
        ZStack(alignment: .trailing){
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor( isSelected ? Color.defaultColor.opacity(0.5) : Color.gray.opacity(0.0001))
                .padding([.leading, .trailing], -10)
            
            HStack(spacing: 8) {
                Group {
                    Image(item.image)
                        .resizable()
                        .frame(width: 14, height: 14)
                        .foregroundColor( isSelected ? .sidebarTextColor : Color.defaultColor )
                }
                Text(item.title)
                    .foregroundColor(.sidebarTextColor)
                    .font(.system(size: 13, weight: .regular ))
                Spacer()
            }
        }
        .frame(height: 28)
        .contentShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
        .padding()
        .onTapGesture {
            self.selectedMenu = self.item
        }
    }
}


