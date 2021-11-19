//
//  DropDownMenuSelectPath.swift
//  LJM
//
//  Created by Tony Tresgots on 18/02/2021.
//

import SwiftUI

struct DropDownMenuSelectPath: View {
        
    @Binding var selectedPath : String?

    @EnvironmentObject var learningPathStore: LearningPathStore
    
    var body: some View {
        Menu {
            ForEach(learningPathStore.learningPaths, id: \.title) { learningPath in
                Button {
                    selectedPath = learningPath.title
                } label: {
                    Text(learningPath.title)
                }
            }
        } label: {
            Text((selectedPath == "" ? "Pick a path" : selectedPath) ?? "Pick a path")
        }.frame(width: 250)
    }
}
