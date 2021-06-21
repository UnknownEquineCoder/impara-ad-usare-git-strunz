//
//  ScrollViewLearningObjectives.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct ScrollViewLearningObjectives: View {
    @Environment(\.colorScheme) var colorScheme
    
    //    @EnvironmentObject var learningPathsStore: LearningPathStore
    //    @EnvironmentObject var studentLearningObjectivesStore: StudentLearningObjectivesStore
    //    @EnvironmentObject var mapLearningObjectivesStore: MapLearningObjectivesStore
    //    @EnvironmentObject var challengeStore: ChallengesStore
    
    @ObservedObject var totalLOs : TotalNumberLearningObjectives
    
    @Binding var learningPathSelected : String?
    
    var filterCore: CoreEnum.RawValue?
    var filteredMap: MapEnum.RawValue?
    var filterChallenge: ChallengeEnum.RawValue?
    let storage = LJM.storage
    
    var filteredLearningObjectives: [LearningObjective] {
        let objectives = Stores.learningObjectives.rawData
        
        switch filterCore {
        case "Core":
            return objectives
                .filter { $0.isCore() }
                .sorted { $0.learningGoal?.lowercased() ?? "No Title" < $1.learningGoal?.lowercased() ?? "NoTitle"}
        case "Elective":
            return objectives
                .filter { !$0.isCore() }
                .sorted { $0.learningGoal?.lowercased() ?? "No Title" < $1.learningGoal?.lowercased() ?? "NoTitle"}
        case "Evaluated":
            return objectives
                .filter { ($0.assessments ?? []).count > 0  }
                .sorted { $0.learningGoal?.lowercased() ?? "No Title" < $1.learningGoal?.lowercased() ?? "NoTitle"}
        default:
            return objectives
                .sorted { $0.learningGoal?.lowercased() ?? "No Title" < $1.learningGoal?.lowercased() ?? "NoTitle"}
        }
    }
    
    var filteredLearningObjectivesMap: [LearningObjective] {
        #warning("REVERT THIS")
//        switch filteredMap {
//        case "FULL MAP":
//            return Stores.learningObjectives.rawData
//        case "COMMUNAL":
//            return Stores.learningObjectives.rawData
//                .filter { $0.isCore() }
//        case let filterPathsTab:
//            if filterPathsTab != nil {
//                return sortLearningObjectivesMap(learningPaths: Stores.learningPaths.rawData, selectedPath: filterPathsTab!)
//            } else {
//                return filteredChallenges
//            }
//
//        }
        
        
        
        return Stores.learningObjectives.rawData
    }
    
    var filteredChallenges: [LearningObjective] {
        switch filterChallenge {
        case let filterChallengeTab:
            if filterChallengeTab != nil {
                return sortLearningObjectivesByChallenge(challenges: Stores.learningPaths.rawData, selectedChallenge: filterChallengeTab!)
            } else {
                return [LearningObjective]()
            }
        }
    }
    
    var isAddable = false
    
    var textFromSearchBar: String
    var selectedStrands: [String]
    
    var body: some View {
        List(filteredLearningObjectives) { item in
            if textFromSearchBar.isEmpty || (item.learningGoal!.lowercased().contains(textFromSearchBar.lowercased())) || ((item.description!.lowercased().contains(textFromSearchBar.lowercased()))) {
                if let strand = item.strand {
                    if self.selectedStrands.contains(strand) || self.selectedStrands.count == 0 {
                        LearningObjectiveJourneyCell(rating: item.assessments?.first?.score ?? 0, isRatingView: isAddable, isAddable: isAddable, learningPathSelected: self.$learningPathSelected, learningObj: item)
                            .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                            .contextMenu {
                                if !isAddable {
                                    Button {
                                        
                                            Webservices.deleteLearningObjectiveFromStudentJourney(id: item.id) { (deletedLearningObj, err) in
                                                //  self.studentLearningObjectivesStore.removeItem(item)
//                                                storage.studentLearningObjectives.remove(object: item)
                                            }
                                        
                                    } label: {
                                        Text("Delete")
                                    }
                                }
                            }
                    }
                }
            }
        }.removeBackground()
        .onChange(of: self.filteredLearningObjectives) { result in
            self.totalLOs.total = result.count
        }
        .onChange(of: self.textFromSearchBar) { result in
            if result != "" {
                self.totalLOs.total = self.filteredLearningObjectives.filter({ (LO) -> Bool in
                    LO.description?.lowercased().contains(result.lowercased()) ?? false || LO.learningGoal?.lowercased().contains(result.lowercased()) ?? false
                    
                }).count
            } else {
                self.totalLOs.total = self.filteredLearningObjectives.count
            }
        }
        .onChange(of: self.selectedStrands) { result in
            if !result.isEmpty {
                self.totalLOs.total = self.filteredLearningObjectives.filter({ (LO) -> Bool in
                    result.contains(LO.strand ?? "")
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
                arrayFullMapLearningObjectives.append(contentsOf: learningPath.learningObjectives())
            } else {
                arrayFullMapLearningObjectives.append(contentsOf: learningPath.learningObjectives())
            }
        }
        return arrayFullMapLearningObjectives
    }
    
    func sortLearningObjectives(learningObj: [LearningObjective]) -> [LearningObjective] {
        
        //    var arrayOfLearningObjectives : [LearningObjective] = [LearningObjective]()
        
        return learningObj
        
        //        if learningPaths != nil && learningPaths.count > 0 {
        //            for learningPath in learningPaths {
        //                if selectedPath != "" {
        //                    if learningPath.title?.lowercased() == selectedPath.lowercased() {
        //                        for learningObjective in self.studentLearningObjectivesStore.learningObjectives {
        //                            if learningObjective.learningPaths != nil {
        //                                for lp in learningObjective.learningPaths! {
        //                                    if lp._id == learningPath.id {
        //                                        print("OIJUHYHIJ \(learningObjective)")
        //                                        arrayOfLearningObjectives.append(learningObjective)
        //                                    }
        //                                }
        //                            }
        //                        }
        //                    }
        //                } else {
        //                    print("IJOUHYBINJOK")
        //                    arrayOfLearningObjectives.append(contentsOf: self.studentLearningObjectivesStore.learningObjectives)
        //                    break
        //                }
        //            }
        //            return arrayOfLearningObjectives
        //        } else {
        //            return arrayOfLearningObjectives
        //        }
    }
    
    func sortLearningObjectivesByChallenge(challenges: [LearningPath], selectedChallenge: String) -> [LearningObjective] {
        
        var arrayOfLearningObjectives : [LearningObjective] = [LearningObjective]()
        
        if challenges.count > 0 {
            for challenge in challenges {
                
                if selectedChallenge != "" {
                    if challenge.name.lowercased().replacingOccurrences(of: "challenge ", with: "") == selectedChallenge.lowercased() {
                        arrayOfLearningObjectives.append(contentsOf: challenge.learningObjectives())
                    }
                } else {
                    for learningObjective in Stores.learningPaths.rawData {
                        
                        arrayOfLearningObjectives.append(contentsOf:learningObjective.learningObjectives())
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
        
        if learningPaths.count > 0 {
            for learningPath in learningPaths {
                
                if selectedPath != "" {
                    
                    if learningPath.name.lowercased() == selectedPath.lowercased() {
                        arrayOfLearningObjectives.append(contentsOf: learningPath.learningObjectives() )
                    }
                } else {
                    arrayOfLearningObjectives.append(contentsOf: Stores.learningObjectives.rawData)
                    
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
                    value = assessment.score ?? 0
                }
            }
        }
        return value
    }
}
