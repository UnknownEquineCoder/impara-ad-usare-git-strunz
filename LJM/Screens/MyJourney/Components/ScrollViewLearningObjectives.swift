//
//  ScrollViewLearningObjectives.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct ScrollViewLearningObjectives: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var learningPathSelected : String?
    
    var filterCore: CoreEnum.RawValue?
    var filteredMap: MapEnum.RawValue?
    var filterChallenge: ChallengeEnum.RawValue?
    var filterCompass: CompassEnum.RawValue?
    var filterLearningGoal: String?
        
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var totalNumberLearningObjectivesStore: TotalNumberOfLearningObjectivesStore
    
    var filteredLearningObjectivesMyJourney: [learning_Objective] {
        let objectives = self.learningObjectiveStore.learningObjectives
        
        switch filterCore {
        case "Communal":
            return objectives
                .filter { $0.isCore && !$0.eval_score.isEmpty }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "Elective":
            return objectives
                .filter { !$0.isCore && !$0.eval_score.isEmpty }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "Evaluated":
            return objectives
                .filter { $0.eval_score.count > 2 }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "Not Evaluated":
            return objectives
                .filter { $0.eval_score.count == 1 }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "All":
            return objectives
                .filter { !$0.eval_score.isEmpty }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        default:
            return filteredLearningObjectivesMap
        }
    }
    
    var filteredLearningObjectivesMap: [learning_Objective] {
        switch filteredMap {
        case "FULL MAP":
            return self.learningObjectiveStore.learningObjectives
        case "COMMUNAL":
            return self.learningObjectiveStore.learningObjectives
                .filter { $0.isCore }
        case "ELECTIVE":
            return self.learningObjectiveStore.learningObjectives
                .filter { !($0.isCore) }
        case let filterPathsTab:
            if filterPathsTab != nil {
                return sortLearningObjectivesMap(learningPaths: learningPathStore.learningPaths, selectedPath: filterPathsTab!)
            } else {
                return filteredChallenges
            }
        }
    }
    
    var filteredChallenges: [learning_Objective] {
        switch filterChallenge {
        case let filterChallengeTab:
            if filterChallengeTab != nil {
//                return sortLearningObjectivesByChallenge(challenges: self.shared.learning_Objectives, selectedChallenge: filterChallengeTab!)
                return self.learningObjectiveStore.learningObjectives
            } else {
                return filteredCompass
            }
        }
    }
    
    var filteredCompass: [learning_Objective] {
        switch filterCompass {
        
        case "Core":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .filter { $0.isCore }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "Elective":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .filter { !($0.isCore) }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "Added":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .filter { !$0.eval_score.isEmpty }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "Not Added":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .filter { $0.eval_score.isEmpty }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "All":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        default:
            return [learning_Objective]()
        }
    }
    
    var isAddable = false
    
    var textFromSearchBar: String
    var selectedStrands: [String]
    
    var body: some View {
        ScrollView{
            LazyVStack {
                ForEach(filteredLearningObjectivesMyJourney, id: \.ID) { item in
                    if textFromSearchBar.isEmpty || (item.goal.lowercased().contains(textFromSearchBar.lowercased())) || ((item.description.lowercased().contains(textFromSearchBar.lowercased()))) {
                        if let strand = item.strand {
                            if self.selectedStrands.contains(strand) || self.selectedStrands.count == 0 {
                                LearningObjectiveJourneyCell(rating: item.eval_score.last ?? 0, isRatingView: true, isAddable: isAddable, isLearningGoalAdded: self.filterLearningGoal != nil ? true : nil, learningPathSelected: self.$learningPathSelected, learningObj: item)
                                    .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                                    .contextMenu {
                                        if !isAddable {
                                            Button {
                                                // remove learning objective
                                            
                                            } label: {
                                                Text("Delete")
                                            }
                                        }
                                    }
                                    
                            }
                        }
                    }
                }
            }.padding(.vertical, 20)
        }.onChange(of: self.filteredLearningObjectivesMyJourney) { result in
            self.totalNumberLearningObjectivesStore.total = result.count
        }
        .onChange(of: self.textFromSearchBar) { result in
            if result != "" {
                self.totalNumberLearningObjectivesStore.total = self.filteredLearningObjectivesMyJourney.filter({ (LO) -> Bool in
                    LO.description.lowercased().contains(result.lowercased()) || LO.goal.lowercased().contains(result.lowercased())
                }).count
            } else {
                self.totalNumberLearningObjectivesStore.total = self.filteredLearningObjectivesMyJourney.count
            }
        }
        .onChange(of: self.selectedStrands) { result in
            if !result.isEmpty {
                self.totalNumberLearningObjectivesStore.total = self.filteredLearningObjectivesMyJourney.filter({ (LO) -> Bool in
                    result.contains(LO.strand)
                }).count
            } else {
                self.totalNumberLearningObjectivesStore.total = self.filteredLearningObjectivesMyJourney.count
            }
        }
        .onReceive(totalNumberLearningObjectivesStore.$changeViewTotal) { (result) in
            self.totalNumberLearningObjectivesStore.total = self.filteredLearningObjectivesMyJourney.count
        }
    }
    
    func sortLearningObjectivesMap(learningPaths: [learning_Path], selectedPath: String) -> [learning_Objective] {
        
        let learning_Path_Index = learningPaths.firstIndex(where: {$0.title == selectedPath})!
        
        let arrayOfLearningObjectives = learningObjectiveStore.learningObjectives.filter { learning_Objective in
            learningPaths[learning_Path_Index].learning_Objective_IDs.contains(learning_Objective.ID)
        }
        
        return arrayOfLearningObjectives
    }
    
    func sortLearningObjectivesCompass(learningGoal: String) -> [learning_Objective] {
        
        var arrayOfLearningObjectives : [learning_Objective] = [learning_Objective]()

        for learningObj in self.learningObjectiveStore.learningObjectives {
            if learningObj.goal == learningGoal {
                arrayOfLearningObjectives.append(learningObj)
            }
        }
        return arrayOfLearningObjectives
    }
}
