//
//  ScrollViewLearningObjectives.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct ScrollViewLearningObjectives: View {
    @Environment(\.colorScheme) var colorScheme
    
    var learningObjectivesSample = [LearningObj(title: "Design", subtitle: "Prototyping", core: .core, desc: "You can understand and apply concepts with assistance.", color: Color.customCyan, challenge: [.MC1, .WF3], rating: 4, ratingGoal: 4), LearningObj(title: "Business", subtitle: "Subtitle", core: .elective, desc: "You can understand and apply concepts with assistance.", color: Color.yellow, challenge: [.MC1, .WF3], rating: 2, ratingGoal: 4), LearningObj(title: "Frontend", subtitle: "Subtitle", core: .core, desc: "You can understand and apply concepts with assistance.", color: Color.blue, challenge: [.MC1], rating: 3, ratingGoal: 4), LearningObj(title: "Backend", subtitle: "Whatever", core: .evaluated, desc: "You can understand and apply concepts with assistance.", color: Color.red, challenge: [.MC1], rating: 4, ratingGoal: 4), LearningObj(title: "Yoyo", subtitle: "Subtitle", core: .evaluated, desc: "You can understand and apply concepts with assistance.", color: Color.purple, challenge: [.MC1, .E5], rating: nil, ratingGoal: 4)]
    
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
                        LearningObjectiveJourneyCell(rating: item.rating ?? 0, isAddable: self.isAddable, title: item.title, subtitle: item.subtitle, core: item.core.rawValue, description: item.desc, color: item.color)
                            .background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255) : .white)
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
