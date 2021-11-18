//
//  ContextMenuTest.swift
//  LJM
//
//  Created by Laura Benetti on 25/10/21.
//

import Foundation
import SwiftUI

struct SortButtonMenu: View {
    
    @Binding var selectedSort: SortEnum?
    @State private var isPop = false
    @State private var text = ""
    @State var showSheet = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {

        Menu {
            Button { withAnimation { selectedSort = .first_Assest } }
                label: {
                    HStack{
                        Text("Most Recent")
                        Image(systemName: "checkmark")
                            .isHidden(selectedSort != .first_Assest)
                    }
                }
            
            Button { withAnimation { selectedSort = .last_Assest } }
        label: {
            HStack {
                Text("Least Recent")
                Image(systemName: "checkmark")
                    .isHidden(selectedSort != .last_Assest)
            }
        }
            Button { withAnimation { selectedSort = .mostEvalFirst } }
                label: {
                    HStack{
                        Text("Most Evaluated First")
                        Image(systemName: "checkmark")
                            .isHidden(selectedSort != .mostEvalFirst)
                        }
                    }
            Button { withAnimation { selectedSort = .leastEvalFirst } }
                label: {
                    HStack{
                        Text("Least Evaluated First")
                        Image(systemName: "checkmark")
                            .isHidden(selectedSort != .leastEvalFirst)
                    }
                }
            
        } label: {
            HStack(spacing: 13) {
                Image(systemName: "arrow.up.arrow.down.circle")
                    .resizable()
                    .foregroundColor(colorScheme == .dark ? Color(red: 160/255, green: 159/255, blue: 159/255) : Color(red: 87/255, green: 87/255, blue: 87/255))
//                    .frame(width: 10, height: 10, alignment: .center)
                Text("Sort by")
//                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? Color(red: 160/255, green: 159/255, blue: 159/255) : Color(red: 87/255, green: 87/255, blue: 87/255))
            }

        }
        .frame(width: 132.toScreenSize(), height: 35.toScreenSize(), alignment: .center)
//        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
//        .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
//        .buttonStyle(BorderedButtonStyle())
        .menuStyle(BorderedButtonMenuStyle())

    }
}



struct SortButtonMenu_Previews: PreviewProvider {

    static var previews: some View {
        SortButtonMenu(selectedSort: .constant(.last_Assest))
    }
}



