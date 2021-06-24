//
//  DropDownMenuSelectPath.swift
//  LJM
//
//  Created by Tony Tresgots on 18/02/2021.
//

import SwiftUI

struct DropDownMenuSelectPath: View {
    
//    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    @Binding var selectedPath : String?
    
    var body: some View {
        Menu {
            ForEach(Stores.learningPaths.rawData) { learningPath in
                Button {
                    selectedPath = learningPath.name
                } label: {
                    Text(learningPath.name)
                }
            }
        } label: {
            Text((selectedPath == "" ? "Select a path" : selectedPath) ?? "Select a path")
        }.frame(width: 250)
    }
}
