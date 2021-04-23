//
//  DropDownMenuSelectPath.swift
//  LJM
//
//  Created by Tony Tresgots on 18/02/2021.
//

import SwiftUI

struct DropDownMenuSelectPath: View {
    
    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    @Binding var selectedPath : String?
    
    var body: some View {
        Menu {
            ForEach(learningPathsStore.learningPaths) { learningPath in
                Button {
                    selectedPath = learningPath.title ?? ""
                } label: {
                    Text(learningPath.title ?? "No title")
                }
            }
        } label: {
            Text((selectedPath == "" ? "Select your path" : selectedPath) ?? "Select your path")
        }.frame(width: 250)
    }
}
