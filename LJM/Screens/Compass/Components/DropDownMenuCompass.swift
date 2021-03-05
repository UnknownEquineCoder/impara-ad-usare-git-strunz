//
//  DropDownMenuCompass.swift
//  LJM
//
//  Created by Laura Benetti on 03/03/21.
//

import Foundation
import SwiftUI

struct DropDownMenuCompass: View{
    
    var paths = ["UI/UX", "Business", "Backend", "Frontend", "Game"]
    @Binding var selectedPath: String
    
    var body: some View{
        Menu {
            ForEach(paths, id: \.self) { path in
                Button {
                    selectedPath = path
                } label: {
                    Text(path)
                }
            }
        } label: {
            Text(selectedPath == "" ? "Select your path" : selectedPath)
        }
        .frame(width: 156.toScreenSize())
    }
}


