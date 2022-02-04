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
            if isSelected {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.secondary.opacity(0.1))
                    .padding([.leading, .trailing], -10)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.gray.opacity(0.0001))
                    .padding([.leading, .trailing], -10)
            }
            
            HStack(spacing: 15) {
                Group {
                    Image(item.image)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color.defaultColor)
                }
                Text(item.title)
                    .foregroundColor(isSelected ? .customBlack : .primary)
                    .font(.system(size: 18, weight: .regular))
                Spacer()
            }
        }
        .frame(height: 40)
        .contentShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding()
        .onTapGesture {
            self.selectedMenu = self.item
        }
    }
}


