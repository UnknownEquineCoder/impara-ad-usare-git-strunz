//
//  ScrollViewLearningObjectives.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct ScrollViewLearningObjectives: View {
    
    var learningObjectivesSample = [LearningObj(title: "Design", subtitle: "Prototyping", core: .core, desc: "You can understand and apply concepts with assistance.", color: Color.customCyan, challenge: [.MC1, .WF3]), LearningObj(title: "Business", subtitle: "Subtitle", core: .elective, desc: "You can understand and apply concepts with assistance.", color: Color.yellow, challenge: [.MC1, .WF3]), LearningObj(title: "Frontend", subtitle: "Subtitle", core: .core, desc: "You can understand and apply concepts with assistance.", color: Color.blue, challenge: [.MC1]), LearningObj(title: "Backend", subtitle: "Whatever", core: .evaluated, desc: "You can understand and apply concepts with assistance.", color: Color.red, challenge: [.MC1]), LearningObj(title: "Yoyo", subtitle: "Subtitle", core: .evaluated, desc: "You can understand and apply concepts with assistance.", color: Color.purple, challenge: [.MC1, .E5])]
    
    var filterCore: CoreEnum.RawValue?
    var filterChallenge: ChallengeEnum.RawValue?
    
    var filteredLO: [LearningObj] {
        switch filterCore {
        case "Core":
            return learningObjectivesSample.filter { $0.core == .core }
        case "Elective":
            return learningObjectivesSample.filter { $0.core == .elective }
        case "Evaluated":
            return learningObjectivesSample.filter { $0.core == .evaluated }
        default:
            return filteredChallenges
        }
    }
    
    var filteredChallenges: [LearningObj] {
        switch filterChallenge {
        case "MC1":
            return learningObjectivesSample.filter { $0.challenge.contains(.MC1) }
        case "E5":
            return learningObjectivesSample.filter { $0.challenge.contains(.E5) }
        case "WF3":
            return learningObjectivesSample.filter { $0.challenge.contains(.WF3) }
        default:
            return learningObjectivesSample
        }
    }
    
    var isAddable = false
    
    var body: some View {
        GeometryReader { gp in
            ScrollView(showsIndicators: true) {
                LazyVStack {
                    ForEach(filteredLO) { item in
                        LearningObjectiveJourneyCell(isAddable: self.isAddable, title: item.title, subtitle: item.subtitle, core: item.core.rawValue, description: item.desc, color: item.color)
                            .background(Color.white)
                    }
                }.frame(width: gp.size.width)
            }
        }
    }
}

struct ScrollViewLearningObjectives_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewLearningObjectives(filterCore: "Core")
    }
}
