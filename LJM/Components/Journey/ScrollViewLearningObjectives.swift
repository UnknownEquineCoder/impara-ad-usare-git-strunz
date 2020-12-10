//
//  ScrollViewLearningObjectives.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct ScrollViewLearningObjectives: View {
    
    var learningObjectivesSample = [LearningObjItem(title: "Design", subtitle: "Prototyping", core: "Core", desc: "You can understand and apply concepts with assistance.", color: Color.customCyan), LearningObjItem(title: "Business", subtitle: "Subtitle", core: "Core", desc: "You can understand and apply concepts with assistance.", color: Color.yellow), LearningObjItem(title: "Frontend", subtitle: "Subtitle", core: "Core", desc: "You can understand and apply concepts with assistance.", color: Color.blue), LearningObjItem(title: "Backend", subtitle: "Whatever", core: "Core", desc: "You can understand and apply concepts with assistance.", color: Color.red), LearningObjItem(title: "Yoyo", subtitle: "Subtitle", core: "Core", desc: "You can understand and apply concepts with assistance.", color: Color.purple)]
    
    var isAddable = false
    
    var body: some View {
        GeometryReader { gp in
            ScrollView(showsIndicators: true) {
                LazyVStack {
                    ForEach(learningObjectivesSample) { item in
                        LearningObjectiveJourneyCell(isAddable: self.isAddable, title: item.title, subtitle: item.subtitle, core: item.core, description: item.desc, color: item.color)
                            .background(Color.white)
                    }
                }.frame(width: gp.size.width)
            }
        }
    }
}

struct LearningObjItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let core: String
    let desc: String
    let color: Color
}

struct ScrollViewLearningObjectives_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewLearningObjectives()
    }
}
