//
//  ScrollViewLearningObjectives.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct ScrollViewLearningObjectives: View {
    var learningObjectivesSample = ["", "", "", "", ""]
    var isAddable = false
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            LazyVStack {
                ForEach (0..<learningObjectivesSample.count) { status in
                    LearningObjectiveJourneyCell(isAddable: self.isAddable, title: "Design", subtitle: "Prototyping", core: "Core", description: "I can create low fidelity paper prototypes and sketches")
                        .background(Color.white)
                }
            }
        }
    }
}

struct ScrollViewLearningObjectives_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewLearningObjectives()
    }
}
