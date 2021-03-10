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
    @EnvironmentObject var studentLearningObjectivesStore: StudentLearningObjectivesStore
    @EnvironmentObject var mapLearningObjectivesStore: MapLearningObjectivesStore
    
    @ObservedObject var totalLOs : TotalNumberLearningObjectives
    @ObservedObject var selectedSegmentView : SelectedSegmentView
    
    var learningPathSelected = ""
    
    var filterCore: CoreEnum.RawValue?
    var filteredMap: MapEnum.RawValue?
    var filterChallenge: ChallengeEnum.RawValue?
    
    var filteredLearningObjectives: [LearningObjective] {
        
        switch filterCore {
        case "Core":
            print("ffqdeseefffrfef")
            
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected).filter { $0.isCore ?? false }
        case "Elective":
            print("ffeffefffrfef")
            
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected).filter { (!($0.isCore ?? false) ) }
        case "Evaluated":
            print("ffefffeefffrfef")
            
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected).filter { $0.assessments?.first?.value ?? 0 > 0 }
        case "All":
            print("ffffrfef")
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected)
        default:
            print("ffffsefeeftffrfef")
            return filteredLearningObjectivesMap
            
        }
    }
    
    var filteredLearningObjectivesMap: [LearningObjective] {
        switch filteredMap {
        case "FULL MAP":
            //            return displayFullMapLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedFilter: nil)
            return self.mapLearningObjectivesStore.learningObjectives
        case "COMMUNAL":
            return self.mapLearningObjectivesStore.learningObjectives
        default:
            return [LearningObjective]()
        }
    }
    
    //    var filteredChallenges: [LearningObjective] {
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
    
    var textFromSearchBar: String
    var selectedStrands: [String]
    
    var body: some View {
        
        ScrollView(showsIndicators: true) {
            
            LazyVStack {
                ForEach(filteredLearningObjectives) { item in
                    if textFromSearchBar.isEmpty || (item.title!.lowercased().contains(textFromSearchBar.lowercased())) || ((item.description!.lowercased().contains(textFromSearchBar.lowercased()))) {
                        if item.strand != nil {
                            if self.selectedStrands.contains(item.strand!) || self.selectedStrands.count == 0 {
                                LearningObjectiveJourneyCell(rating: item.assessments?.first?.value ?? 0, isRatingView: isAddable ? true : false, isAddable: isAddable, learningObjective: item)
                                    .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                            }
                        }
                    }
                }
            }
        }
        .onChange(of: self.filteredLearningObjectives) { result in
            self.totalLOs.total = result.count
        }
        .onChange(of: self.textFromSearchBar) { result in
            if result != "" {
                self.totalLOs.total = self.filteredLearningObjectives.filter({ (LO) -> Bool in
                    LO.description?.lowercased().contains(result.lowercased()) ?? false || LO.title?.lowercased().contains(result.lowercased()) ?? false
                    
                }).count
            } else {
                self.totalLOs.total = self.filteredLearningObjectives.count
            }
        }
        .onChange(of: self.selectedStrands) { result in
            if !result.isEmpty {
                self.totalLOs.total = self.filteredLearningObjectives.filter({ (LO) -> Bool in
                    result.contains(LO.strand ?? "No Strand")
                }).count
            } else {
                self.totalLOs.total = self.filteredLearningObjectives.count
            }
        }
        .onReceive(totalLOs.$changeViewTotal) { (result) in
            self.totalLOs.total = self.filteredLearningObjectives.count
        }
    }
    
    func displayFullMapLearningObjectives(learningPaths: [LearningPath], selectedFilter: String?) -> [LearningObjective] {
        var arrayFullMapLearningObjectives : [LearningObjective] = [LearningObjective]()
        
        for learningPath in learningPaths {
            if selectedFilter != nil || selectedFilter != "" {
                arrayFullMapLearningObjectives.append(contentsOf: learningPath.learningObjectives!)
            } else {
                arrayFullMapLearningObjectives.append(contentsOf: learningPath.learningObjectives!)
            }
        }
        return arrayFullMapLearningObjectives
    }
    
    func sortLearningObjectives(learningPaths: [LearningPath], selectedPath: String) -> [LearningObjective] {
        
        var arrayOfLearningObjectives : [LearningObjective] = [LearningObjective]()
        
        if learningPaths != nil && learningPaths.count > 0 {
            for learningPath in learningPaths {
                if selectedPath != "" {
                    if learningPath.title?.lowercased() == selectedPath.lowercased() {
                        for learningObjective in self.studentLearningObjectivesStore.learningObjectives {
                            for LO in learningPath.learningObjectives! {
                                if LO.id == learningObjective.id {
                                    arrayOfLearningObjectives.append(learningObjective)
                                }
                            }
                        }
                    }
                } else {
                    arrayOfLearningObjectives.append(contentsOf: self.studentLearningObjectivesStore.learningObjectives)
                    break
                }
            }
            return arrayOfLearningObjectives
        } else {
            return arrayOfLearningObjectives
        }
    }
    
    func getAssessmentRelatedToLearningObjective(learningObjectiveId: String, assessments: [Assessment]?) -> Int? {
        var value = 0
        if assessments != nil {
            for assessment in assessments! {
                if assessment.learningObjectiveId == learningObjectiveId {
                    value = assessment.value ?? 0
                }
            }
        }
        return value
    }
    
    func setupTitleLearningObjective(learningPaths: LearningPathStore, learningObjectiveId: String) -> String {
        var title = ""
        if learningPaths != nil && learningPaths.learningPaths.count > 0 {
            for learningPath in learningPaths.learningPaths {
                for learningObjective in learningPath.learningObjectives! {
                    if learningObjective.id == learningObjectiveId {
                        title = learningPath.title ?? ""
                    }
                }
            }
        }
        return title
    }
}
