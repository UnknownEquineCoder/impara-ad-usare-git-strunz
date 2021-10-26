//
//  ContextMenuTest.swift
//  LJM
//
//  Created by Laura Benetti on 18/10/21.
//

import Foundation
import SwiftUI

struct ContextMenuFilters: View {
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Menu {
            Menu("View"){
                Button("Full Map", action: {})
                Button("Communal", action: {})
                Button("Elective", action: {})
            }
            Menu("Paths") {
                Button("UI/UX", action: {})
                Button("Frontend", action: {})
                Button("Backend", action: {})
                Button("Game", action: {})
                Button("Business", action: {})
            }
            Menu("Strands"){
                Button("App Business and Marketing", action: {})
                Button("Process", action: {})
                Button("Professional Skills", action: {})
                Button("Technical", action: {})
                Button("Design", action: {})
            }
        } label: {
            HStack(spacing: 13) {
                Image(systemName: "camera.filters")
                    .resizable()
                    .frame(width: 10, height: 10)
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
        ContextMenuFilters()
    }
}



