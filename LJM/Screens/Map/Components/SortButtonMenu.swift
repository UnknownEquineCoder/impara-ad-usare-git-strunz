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
        } label: {
            HStack(spacing: 13) {
                Image(systemName: "arrow.up.arrow.down.circle")
                    .resizable()
                    .foregroundColor(Color.gray160)
                Text("Sort by")
                    .foregroundColor(Color.gray160)
            }

        }
        .frame(width: 132.toScreenSize(), height: 35.toScreenSize(), alignment: .center)
        .menuStyle(BorderedButtonMenuStyle())

    }
}



struct SortButtonMenu_Previews: PreviewProvider {

    static var previews: some View {
        SortButtonMenu(selectedSort: .constant(.last_Assest))
    }
}



