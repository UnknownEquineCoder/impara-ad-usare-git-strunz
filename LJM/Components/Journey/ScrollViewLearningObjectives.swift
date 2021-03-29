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
    @EnvironmentObject var challengeStore: ChallengesStore
    
    @ObservedObject var totalLOs : TotalNumberLearningObjectives
    @ObservedObject var selectedSegmentView : SelectedSegmentView
    
    var learningPathSelected = ""
    
    var filterCore: CoreEnum.RawValue?
    var filteredMap: MapEnum.RawValue?
    var filterChallenge: ChallengeEnum.RawValue?
    
    var filteredLearningObjectives: [LearningObjective] {
        
        switch filterCore {
        case "Core":
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected)
                .filter { $0.isCore ?? false }
                .sorted { $0.title?.lowercased() ?? "No Title" < $1.title?.lowercased() ?? "NoTitle"}
        case "Elective":
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected)
                .filter { (!($0.isCore ?? false) ) }
                .sorted { $0.title?.lowercased() ?? "No Title" < $1.title?.lowercased() ?? "NoTitle"}
        case "Evaluated":
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected)
                .filter { $0.assessments?.first?.value ?? 0 > 0 }
                .sorted { $0.title?.lowercased() ?? "No Title" < $1.title?.lowercased() ?? "NoTitle"}
        case "All":
            return sortLearningObjectives(learningPaths: learningPathsStore.learningPaths, selectedPath: learningPathSelected)
                .sorted { $0.title?.lowercased() ?? "No Title" < $1.title?.lowercased() ?? "NoTitle"}
        default:
            return filteredLearningObjectivesMap
        }
    }
    
    var filteredLearningObjectivesMap: [LearningObjective] {
        switch filteredMap {
        case "FULL MAP":
            return self.mapLearningObjectivesStore.learningObjectives
        case "COMMUNAL":
            return self.mapLearningObjectivesStore.learningObjectives
                .filter { $0.isCore ?? false }
        case let filterPathsTab:
            if filterPathsTab != nil {
                return sortLearningObjectivesMap(learningPaths: learningPathsStore.learningPaths, selectedPath: filterPathsTab!)
            } else {
                return filteredChallenges
            }

        }
    }
    
    var filteredChallenges: [LearningObjective] {
        switch filterChallenge {
        case let filterChallengeTab:
            if filterChallengeTab != nil {
                return sortLearningObjectivesByChallenge(challenges: self.challengeStore.challenges, selectedChallenge: filterChallengeTab!)
            } else {
                return [LearningObjective]()
            }
        }
    }
    
    var isAddable = false
    
    var textFromSearchBar: String
    var selectedStrands: [String]
    
    var body: some View {
        
        ScrollView(showsIndicators: true) {
            
            LazyVStack {
                ForEach(filteredLearningObjectives) { item in
                    if textFromSearchBar.isEmpty || (item.title!.lowercased().contains(textFromSearchBar.lowercased())) || ((item.description!.lowercased().contains(textFromSearchBar.lowercased()))) {
                        if item.strand != nil {
                            if self.selectedStrands.contains(item.strand!.strand) || self.selectedStrands.count == 0 {
                                LearningObjectiveJourneyCell(rating: item.assessments?.first?.value ?? 0, isRatingView: isAddable ? true : false, isAddable: isAddable, learningObj: item)
                                    .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                                    .contextMenu {
                                        if !isAddable {
                                            Button {
                                                if item.id != nil {
                                                    Webservices.deleteLearningObjectiveFromStudentJourney(id: item.id!) { (deletedLearningObj, err) in
                                                        self.studentLearningObjectivesStore.removeItem(item)
                                                        
                                                    }
                                                }
                                            } label: {
                                                Text("Delete")
                                            }
                                        }
                                    }
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
                    result.contains(LO.strand?.strand ?? "No Strand")
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
                            if learningObjective.learningPaths != nil {
                                for lp in learningObjective.learningPaths! {
                                    if lp._id == learningPath.id {
                                        arrayOfLearningObjectives.append(learningObjective)
                                    }
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
    
    func sortLearningObjectivesByChallenge(challenges: [LearningPath], selectedChallenge: String) -> [LearningObjective] {
        
        var arrayOfLearningObjectives : [LearningObjective] = [LearningObjective]()
        
        if challenges != nil && challenges.count > 0 {
            for challenge in challenges {
                if selectedChallenge != "" {
                    if challenge.title!.lowercased().replacingOccurrences(of: "challenge ", with: "") == selectedChallenge.lowercased() {
                        arrayOfLearningObjectives.append(contentsOf: challenge.learningObjectives ?? [LearningObjective]())
                    }
                } else {
                    for learningObjective in self.challengeStore.challenges {
                        arrayOfLearningObjectives.append(contentsOf:learningObjective.learningObjectives ?? [LearningObjective]())
                    }
                    break
                }
            }
            return arrayOfLearningObjectives
        } else {
            return arrayOfLearningObjectives
        }
    }
    
    func sortLearningObjectivesMap(learningPaths: [LearningPath], selectedPath: String) -> [LearningObjective] {
        
        var arrayOfLearningObjectives : [LearningObjective] = [LearningObjective]()
        
        if learningPaths != nil && learningPaths.count > 0 {
            for learningPath in learningPaths {
                if selectedPath != "" {
                    if learningPath.title!.lowercased() == selectedPath.lowercased() {
                        arrayOfLearningObjectives.append(contentsOf: learningPath.learningObjectives ?? [LearningObjective]())
                    }
                } else {
                    arrayOfLearningObjectives.append(contentsOf:  self.mapLearningObjectivesStore.learningObjectives)
                    
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
}
