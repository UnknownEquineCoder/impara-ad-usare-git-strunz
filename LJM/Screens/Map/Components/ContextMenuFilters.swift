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
                    .foregroundColor(colorScheme == .dark ? .white : .black)
//                    .frame(width: 10, height: 10, alignment: .center)
                Text("Filters")
//                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
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

//struct MyButtonStyle: ButtonStyle {
//
//  func makeBody(configuration: Self.Configuration) -> some View {
//    configuration.label
//      .padding()
//      .foregroundColor(.white)
//      .background(configuration.isPressed ? Color.customCyan : Color(red: 97/255, green: 95/255, blue: 95/255))
//      .cornerRadius(7.0)
//  }
//
//}



