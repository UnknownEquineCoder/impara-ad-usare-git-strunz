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
    var filterSort: SortEnum?
    var filterLearningGoal: String?
    var filterEvaluatedOrNot: EvaluatedOrNotEnum?
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var totalNumberLearningObjectivesStore: TotalNumberOfLearningObjectivesStore
    
    var filteredLearningObjectivesMyJourney: [learning_Objective] {
        
        let objectives = self.learningObjectiveStore.learningObjectives
            .filter { !$0.eval_score.isEmpty }
            .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        
        switch filterCore {
        case "COMMUNAL":
            return objectives
                .filter { $0.isCore }
            
        case "ELECTIVE":
            return objectives
                .filter { !$0.isCore }
            
        case "FULL MAP":
            return objectives
        default:
            return filteredLearningObjectivesMap
        }
    }
    
    var filteredLearningObjectivesMap: [learning_Objective] {
        switch filteredMap {
        case "FULL MAP":
            return checkForFilterEvaluatedOrNot()
        case "COMMUNAL":
            return checkForFilterEvaluatedOrNot()
                .filter { $0.isCore }
        case "ELECTIVE":
            return checkForFilterEvaluatedOrNot()
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
            
        case "COMMUNAL":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .filter { $0.isCore }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "ELECTIVE":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .filter { !($0.isCore) }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "EVALUATED":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .filter { !$0.eval_score.isEmpty }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "NOT EVALUATED":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .filter { $0.eval_score.isEmpty }
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        case "FULL MAP":
            return sortLearningObjectivesCompass(learningGoal: filterLearningGoal ?? "No Learning Goal")
                .sorted { $0.goal.lowercased() < $1.goal.lowercased() }
        default:
            return [learning_Objective]()
        }
    }
    
    var isAddable = false
    var isLearningGoalAdded: Bool?
    
    @Binding var textFromSearchBar: String
    var selectedStrands: [String]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(filteredLearningObjectivesMyJourney
                            .sorted(by: { first, second in
                    switch filterSort {
                    case .leastEvalFirst:
                        return first.eval_date.count < second.eval_date.count
                    case .mostEvalFirst:
                        return first.eval_date.count > second.eval_date.count
                    case .none:
                        return false
                    case .first_Assest:
                        return (first.eval_date.last ?? Date()) > (second.eval_date.last ?? Date())
                    case .last_Assest:
                        return (first.eval_date.last ?? Date()) < (second.eval_date.last ?? Date())
                    }
                })
                            .filter({
                    textFromSearchBar.isEmpty ||
                    $0.goal.lowercased().contains(textFromSearchBar.lowercased()) ||
                    $0.description.lowercased().contains(textFromSearchBar.lowercased()) ||
                    $0.Keyword.contains(where: {$0.lowercased().contains(textFromSearchBar.lowercased())}) ||
                    $0.strand.lowercased().contains(textFromSearchBar.lowercased()) ||
                    $0.goal_Short.lowercased().contains(textFromSearchBar.lowercased()) ||
                    $0.ID.lowercased().contains(textFromSearchBar.lowercased())
                }), id: \.ID) { item in
                    if let strand = item.strand {
                        if self.selectedStrands.contains(strand) || self.selectedStrands.count == 0 {
                            
                            LearningObjectiveJourneyCell(
                                rating: item.eval_score.last ?? 0,
                                isRatingView: item.eval_score.count > 0,
                                filter_Text: $textFromSearchBar,
                                isAddable: isAddable,
                                isLearningGoalAdded: isLearningGoalAdded == nil ? nil : (isLearningGoalAdded ?? false && item.eval_score.count > 0),
                                learningPathSelected: self.$learningPathSelected,
                                learningObj: item)
                            
                                .contextMenu {
                                    if !isAddable {
                                        Button {
                                            // remove learning objective
                                            let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == item.ID})!
                                            self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.removeAll()
                                            self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_date.removeAll()
                                            
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
        .padding(.bottom, 60)
        .onChange(of: self.filteredLearningObjectivesMyJourney) { result in
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
    
    func checkForFilterEvaluatedOrNot() -> [learning_Objective] {
        return filterEvaluatedOrNot == nil ? learningObjectiveStore.learningObjectives : (filterEvaluatedOrNot == .evaluated ? learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0}) : learningObjectiveStore.learningObjectives.filter({$0.eval_score.count == 0}))
    }
    
    func sortLearningObjectivesMap(learningPaths: [learning_Path], selectedPath: String) -> [learning_Objective] {
        
        var arrayOfLearningObjectives = [learning_Objective]()
        
        if let learning_Path_Index = learningPaths.firstIndex(where: {$0.title == selectedPath}) {
            arrayOfLearningObjectives =
            checkForFilterEvaluatedOrNot()
                .filter { learning_Objective in
                    // algo whenever we have learning objectives related to learning paths
                    //                learningPaths[learning_Path_Index].learning_Objective_IDs.contains(learning_Objective.ID)
                    learning_Objective.core_Rubric_Levels[learning_Path_Index] > 1
                }
        }
        return arrayOfLearningObjectives
    }
    
    func sortLearningObjectivesCompass(learningGoal: String) -> [learning_Objective] {
        
        var arrayOfLearningObjectives : [learning_Objective] = [learning_Objective]()
        
        for learningObj in self.learningObjectiveStore.learningObjectives {
            if learningObj.goal_Short.lowercased() == learningGoal.lowercased() {
                arrayOfLearningObjectives.append(learningObj)
            }
        }
        return arrayOfLearningObjectives
    }
}
