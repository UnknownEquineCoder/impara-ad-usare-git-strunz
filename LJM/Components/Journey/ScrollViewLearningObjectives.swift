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
        switch filterCore {
        
        case "Core":
            return sortLearningObjectives(learningObj: storage.studentLearningObjectives)
                .filter { $0.isCore ?? false }
                .sorted { $0.learningGoal?.lowercased() ?? "No Title" < $1.learningGoal?.lowercased() ?? "NoTitle"}
        case "Elective":
            return sortLearningObjectives(learningObj: storage.studentLearningObjectives)
                .filter { (!($0.isCore ?? false) ) }
                .sorted { $0.learningGoal?.lowercased() ?? "No Title" < $1.learningGoal?.lowercased() ?? "NoTitle"}
        case "Evaluated":
            return sortLearningObjectives(learningObj: storage.studentLearningObjectives)
                .filter { $0.assessments?.first?.value ?? 0 > 0 }
                .sorted { $0.learningGoal?.lowercased() ?? "No Title" < $1.learningGoal?.lowercased() ?? "NoTitle"}
        case "All":
            print(storage.learningObjectives.compactMap { $0.assessments })
            return sortLearningObjectives(learningObj: storage.studentLearningObjectives)
                .filter { ($0.assessments?.count ?? 0) > 0 }
                .sorted { $0.learningGoal?.lowercased() ?? "No Title" < $1.learningGoal?.lowercased() ?? "NoTitle"}
        default:
            return filteredLearningObjectivesMap
        }
    }
    
    var filteredLearningObjectivesMap: [LearningObjective] {
        switch filteredMap {
        case "FULL MAP":
            return storage.mapLearningObjectives
        case "COMMUNAL":
            return storage.mapLearningObjectives
                .filter { $0.isCore ?? false }
        case let filterPathsTab:
            if filterPathsTab != nil {
                return sortLearningObjectivesMap(learningPaths: storage.learningPaths, selectedPath: filterPathsTab!)
            } else {
                return filteredChallenges
            }
            
        }
    }
    
    var filteredChallenges: [LearningObjective] {
        switch filterChallenge {
        case let filterChallengeTab:
            if filterChallengeTab != nil {
                return sortLearningObjectivesByChallenge(challenges: storage.challenges, selectedChallenge: filterChallengeTab!)
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
                if item.strand != nil {
                    if self.selectedStrands.contains(item.strand!.strand) || self.selectedStrands.count == 0 {
                        LearningObjectiveJourneyCell(rating: item.assessments?.first?.value ?? 0, isRatingView: isAddable ? true : false, isAddable: isAddable, learningPathSelected: self.$learningPathSelected, learningObj: item)
                            .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                            .contextMenu {
                                if !isAddable {
                                    Button {
                                        if item.id != nil {
                                            Webservices.deleteLearningObjectiveFromStudentJourney(id: item.id!) { (deletedLearningObj, err) in
                                                //  self.studentLearningObjectivesStore.removeItem(item)
                                                storage.studentLearningObjectives.remove(object: item)
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
        
        if challenges != nil && challenges.count > 0 {
            for challenge in challenges {
                
                if selectedChallenge != "" {
                    if challenge.title!.lowercased().replacingOccurrences(of: "challenge ", with: "") == selectedChallenge.lowercased() {
                        arrayOfLearningObjectives.append(contentsOf: challenge.learningObjectives ?? [LearningObjective]())
                    }
                } else {
                    for learningObjective in storage.challenges {
                        
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
                    arrayOfLearningObjectives.append(contentsOf: storage.mapLearningObjectives)
                    
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
