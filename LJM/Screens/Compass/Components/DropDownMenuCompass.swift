//
//  DropDownMenuCompass.swift
//  LJM
//
//  Created by Laura Benetti on 03/03/21.
//

import Foundation
import SwiftUI

struct DropDownMenuCompass: View{
    
    @Binding var selectedPath: LearningPaths
    
    var body: some View{
        Menu {
            ForEach(LearningPaths.allCases, id: \.self) { path in
                Button {
                    selectedPath = path
                } label: {
                    Text(path == .UI_UX ? path.rawValue.uppercased() : path.rawValue.capitalized)
                }
            }
        } label: {
            Text(selectedPath == .UI_UX ? selectedPath.rawValue.uppercased() : selectedPath.rawValue.capitalized )
        }
        .frame(width: 156.toScreenSize())
    }
}


