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
    var fakePaths : [String]
    
    @EnvironmentObject var learningPathStore: LearningPathStore

    var body: some View {
        Menu {
            ForEach(learningPathStore.learningPaths, id: \.title) { path in
                Button {
                    selectedPath = path.title
                } label: {
                    Text(path.title)
                }
            }
        } label: {
            Text(selectedPath)
        }
        .frame(width: 156.toScreenSize())
    }
}


