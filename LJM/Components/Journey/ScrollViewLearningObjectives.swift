//
//  ScrollViewLearningObjectives.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct ScrollViewLearningObjectives: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    @ObservedObject var totalLOs : TotalNumberLearningObjectives
    
    var learningPathSelected = ""
    
    var learningObjectivesSample = [LearningObjOldVersion(title: "Design", subtitle: "Prototyping", core: .core, desc: "You can understand and apply concepts with assistance.You can understand and apply concepts with assistance.You can understand and apply concepts with assistance.You can understand and apply concepts with assistance.You can understand and apply concepts with assistance.You can understand and apply concepts with assistance.You can understand and apply concepts with assistance.You can understand and apply concepts with assistance.You can understand and apply concepts with assistance.self.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : trueself.expand ? false : true", color: Color.customCyan, challenge: [.MC1, .WF3], rating: 4, ratingGoal: 1), LearningObjOldVersion(title: "Business", subtitle: "Subtitle", core: .elective, desc: "You can understand and apply concepts with assistance.", color: Color.yellow, challenge: [.MC1, .WF3], rating: 2, ratingGoal: nil), LearningObjOldVersion(title: "Frontend", subtitle: "Subtitle", core: .core, desc: "You can understand and apply concepts with assistance.", color: Color.blue, challenge: [.MC1], rating: 3, ratingGoal: 3), LearningObjOldVersion(title: "Backend", subtitle: "Whatever", core: .evaluated, desc: "You can understand and apply concepts with assistance.", color: Color.red, challenge: [.MC1], rating: 4, ratingGoal: 4), LearningObjOldVersion(title: "Yoyo", subtitle: "Subtitle", core: .evaluated, desc: "You can understand and apply concepts with assistance.", color: Color.purple, challenge: [.MC1, .E5], rating: nil, ratingGoal:5)]
    
    var filterCore: CoreEnum.RawValue?
    var filterChallenge: ChallengeEnum.RawValue?
    
    var filteredLO: [LearningObjective] {
        
        switch filterCore {
        case "Core":
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected).filter { $0.isCore! }
        case "Elective":
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected).filter { $0.isElective! }
        case "Evaluated":
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected).filter { $0.isCore! }
        default:
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected)
        }
    }
    
    func sortLearningObjectives(learningPaths: [LearningPath], selectedPath: String) -> [LearningObjective] {
        
        var arrayOfLearningObjectives : [LearningObjective] = [LearningObjective]()
        
        for learningPath in learningPaths {
            if selectedPath != "" {
                if learningPath.title?.lowercased() == selectedPath.lowercased() {
                    arrayOfLearningObjectives.append(contentsOf: (learningPath.learningObjectives as? [LearningObjective])!)
                }
            } else {
                arrayOfLearningObjectives.append(contentsOf: (learningPath.learningObjectives as? [LearningObjective])!)
            }
        }
        return arrayOfLearningObjectives
    }
    
    //    var filteredChallenges: [LearningObjOldVersion] {
    //        switch filterChallenge {
    //        case "MC1":
    //            return learningObjectivesSample.filter { $0.challenge.contains(.MC1) }
    //        case "E5":
    //            return learningObjectivesSample.filter { $0.challenge.contains(.E5) }
    //        case "WF3":
    //            return learningObjectivesSample.filter { $0.challenge.contains(.WF3) }
    //        default:
    //            return learningObjectivesSample
    //        }
    //    }
    
    var isAddable = false
    
    var textFromSearchBar : String
    
    var body: some View {
        GeometryReader { gp in
            ScrollView(showsIndicators: true) {
                LazyVStack {
                    ForEach(filteredLO) { item in
                        if textFromSearchBar.isEmpty || (item.title!.lowercased().contains(textFromSearchBar.lowercased())) || ((item.description!.lowercased().contains(textFromSearchBar.lowercased()))) {
                            LearningObjectiveJourneyCell(rating: 5, isAddable: self.isAddable, title: item.title!, subtitle: item.title!, core: item.isCore! ? "Core" : "Elective", description: item.description!, color: Color.customCyan, goalRating: 3)
                                .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                        }
                    }
                }
            }.frame(width: gp.size.width)
            .onChange(of: self.filteredLO) { result in
                print("OIJHUYGHJ \(result)")
                self.totalLOs.total = result.count
            }
        }
    }
}
