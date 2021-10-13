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
        case .compass:     return "Compass_Icon"
        case .journey:     return "Journey_Icon"
        case .map:         return "Map_Icon"
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
                    .imageScale(.small)
                    .foregroundColor(isSelected ? .customCyan : .primary)
            }
            .frame(width: 40)
            Text(item.title)
                .foregroundColor(isSelected ? .customBlack : .primary)
                .font(.system(size: 20, weight: .medium, design: .rounded))
        }
        .padding()
        .padding(.leading, 25)
        .onTapGesture {
            self.selectedMenu = self.item
        }
    }
}

