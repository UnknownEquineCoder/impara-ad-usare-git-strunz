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
        HStack(spacing: 30) {
            Group {
                Image(item.image)
                    .frame(width: 2.0)
                    .imageScale(.small)
                    .foregroundColor(Color(red: 25/255, green: 144/255, blue: 135/255))
//                    .foregroundColor(isSelected ? .customCyan : .primary)
            }
            .frame(width: 40)
            Text(item.title)
                .foregroundColor(isSelected ? .customBlack : .primary)
                .font(.system(size: 20, weight: .regular))
                .frame(width: 150, alignment: .leading)
        }
        .contentShape(Rectangle())
        .padding()
        .padding(.leading, 25)
        .onTapGesture {
            self.selectedMenu = self.item
        }
    }
}

