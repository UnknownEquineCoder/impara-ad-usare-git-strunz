//
//  DropDownMenuCompass.swift
//  LJM
//
//  Created by Laura Benetti on 03/03/21.
//

import Foundation
import SwiftUI

struct DropDownMenuCompass: View{
    
    @Binding var selectedPath: String
    var fakePaths = ["Design", "Front", "Game"]
    
    var body: some View {
        Menu {
            ForEach(fakePaths, id: \.self) { path in
                Button {
                    selectedPath = path
                } label: {
                    Text(path)
                }
            }
        } label: {
            Text(selectedPath)
        }
        .frame(width: 156.toScreenSize())
    }
}


