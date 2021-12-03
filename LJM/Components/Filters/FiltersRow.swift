//
//  FiltersRow.swift
//  LJM
//
//  Created by Marco Tammaro on 03/12/21.
//

import SwiftUI

struct FiltersRow: View {
    
    var text: String
    var onTap : () -> Bool
    @State var selected: Bool = false
    
    var body: some View {
        HStack{
            Text(text)
            Spacer()
            if self.selected {
                Image(systemName: "checkmark")
            }
        }
        .padding(.bottom, 5)
        .padding(.top, 5)
        .onTapGesture {
            self.selected = self.onTap()
//            self.selected.toggle()
        }
       
    }
 }
