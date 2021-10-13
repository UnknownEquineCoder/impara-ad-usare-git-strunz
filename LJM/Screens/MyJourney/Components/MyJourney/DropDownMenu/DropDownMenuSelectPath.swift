//
//  DropDownMenuSelectPath.swift
//  LJM
//
//  Created by Tony Tresgots on 18/02/2021.
//

import SwiftUI

struct DropDownMenuSelectPath: View {
        
    @Binding var selectedPath : String?
    var fakePaths = ["Game", "Front", "Back", "Design"]
    
    var body: some View {
        Menu {
            ForEach(fakePaths, id: \.self) { learningPath in
                Button {
                    selectedPath = learningPath
                } label: {
                    Text(learningPath)
                }
            }
        } label: {
            Text((selectedPath == "" ? "Select a path" : selectedPath) ?? "Select a path")
        }.frame(width: 250)
    }
}
