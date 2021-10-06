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
    
    @ViewBuilder
    var contentView: some View {
        switch self {
        case .compass:      CompassView()
        case .journey:      MyJourneyMainView()
        case .map:          JourneyMainView()
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
                .foregroundColor(isSelected ? .customCyan : .primary)
                .font(.system(size: 20, weight: .medium, design: .rounded))
        }
        .padding()
        .padding(.leading, 25)
        .onTapGesture {
            self.selectedMenu = self.item
        }
    }
}

// Sidebar old elements

struct SidebarElements: View {
    var buttonName: String
    var buttonIcon: String
    var body: some View {
        HStack{
            Image(buttonIcon)
                .resizable()
                .frame(width: 37.toScreenSize(), height: 37.toScreenSize(), alignment: .center)
                .foregroundColor(.green)
                .padding(.trailing, 8)
            
            Text(buttonName)
                .font(.system(size: 28.toFontSize()))
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
            
            
        }.padding(.leading, 37)
            .padding(.top, 13)
            .padding(.bottom, 13)
            .padding(.trailing, 8)
    }
    
    
}

struct Navigation<V: LJMView>: View{
    var buttonName: String
    var buttonIcon: String
    var tag: Int
    @State var selection: Int?
    
    
    var body: some View{
        NavigationLink(destination: V(), tag: tag, selection: $selection)
        {
            SidebarElements(buttonName: buttonName, buttonIcon: buttonIcon)
        }
    }
    
}
struct SidebarElements_Previews: PreviewProvider {
    static var previews: some View {
        SidebarElements(buttonName: "Placeholder", buttonIcon: "square")
    }
}


