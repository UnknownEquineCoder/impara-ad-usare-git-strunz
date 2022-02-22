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
    
    case compass, journey, map, challenge
    
    var title: String {
        switch self {
        case .compass:      return "Compass"
        case .journey:      return "Journey"
        case .map:          return "Map"
        case .challenge:    return "Challenge"
        }
    }
    
    var image: String {
        switch self {
        case .compass:      return "safari"
        case .journey:      return "suitcase"
        case .map:          return "map"
        case .challenge:    return "sparkles"
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
                    Image(systemName: item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:16,height: 16)
                        .foregroundColor( isSelected ? .sidebarTextColor : Color.defaultColor )
                        .scaleEffect(x: item.image == "puzzlepiece.extension" ? 1 : -1, y: 1, anchor: .center)
                }
                Text(item.title)
                    .font(.body)
                    .foregroundColor(.sidebarTextColor)
                    .padding(.leading, -1)
//                    .font(.system(size: 13, weight: .regular ))
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


