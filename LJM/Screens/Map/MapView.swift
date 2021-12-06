//
//  PathsView.swift
//  LJM
//
//  Created by Laura Benetti on 28/11/2020.
//

import SwiftUI

struct MapView: View {
    @State var selectedFilter = "ALL"
    @State var selectedStrands = [String]()
    @State var expand: Bool = false
    @State private var searchText = ""
//    @State var selectedSort: SortEnum?
    @State private var selectedPath : String?
    @State var selectedEvaluatedOrNotFilter: EvaluatedOrNotEnum?
            
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var selectedSegmentView : SelectedSegmentView
    
    // new data flow
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    @State private var toggleFilters: Bool = false
    // check if the filters was updated
    
    @State var isUpdated : Bool = false
    
    // filtered learning objectives
    
    @State var filtered_Learning_Objectives : [learning_Objective] = []
    @State var filters : Dictionary<String, Array<String>> = [:]
    
    var body: some View {
        
        
            VStack(alignment: .leading) {
                
                
                TitleScreenView(title: "Map")
               
                DescriptionTitleScreenView(desc: "The Map provides access to all the current Learning Objectives in the Academy Curriculum. The Communal Learning Objectives will be adressed during the Challenges and added to your Journey. You can also explore and add Elective Learning Objectives based on your interests and the profile of specific career paths.")
                
                
                HStack {
                    
                    SearchBarExpandableJourney(txtSearchBar: $searchText, isUpdated: $isUpdated)
                    
                    Spacer()
                    HStack{
                        Text("Filters").font(.system(size: 20))
                        Image(systemName: toggleFilters ? "chevron.up" : "chevron.down")
                            .font(.system(size: 20))
                    }.onTapGesture {
                        self.toggleFilters.toggle()
                    }
                }
                
                Filters(
                    viewType: .map,
                    onFiltersChange: { filter in
                        filters = filter
                        filtered_Learning_Objectives = filterLearningObjective(filters: filters)
                    })
                    .opacity(toggleFilters ? 1 : 0)
                    .frame(height: toggleFilters ? .none : 0)
                    .clipped()
                    .animation(.easeOut)
                    .transition(.slide)
                
                ZStack(alignment: .top) {
                    NumberTotalLearningOjbectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                    
                    Text("No learning objectives found ...")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.customDarkGrey)
                        .padding(.top, 75)
                        .isHidden(self.totalNumberLearningObjectivesStore.total == 0 ? false : true)
                    
                    ScrollViewLearningObjectives(learningPathSelected: $selectedPath, isAddable: true, isLearningGoalAdded: nil, textFromSearchBar: $searchText, filtered_Learning_Objectives: $filtered_Learning_Objectives)
                        .padding(.top, 30)
                        .onAppear {
                            filtered_Learning_Objectives = self.learningObjectiveStore.learningObjectives
                            self.totalNumberLearningObjectivesStore.total = filtered_Learning_Objectives.count
                        }
                        .onChange(of: learningObjectiveStore.learningObjectives) { learning_Objectives in
                            filtered_Learning_Objectives = filterLearningObjective(filters: filters)
                        }
                    
                }.padding(.top, 10)
                
        }.padding(.leading, 50).padding(.trailing, 50)
    }
    
    func getLearningPath(learningPaths: [learning_Path]) -> [String] {
        var arrayTitleLearningPath : [String] = [String]()
        
        for learningPath in learningPaths {
            arrayTitleLearningPath.append(learningPath.title)
        }
        
        return arrayTitleLearningPath
    }
    
    func checkIfMyJourneyIsEmpty() -> Bool {
        let evaluated_Objectives = self.learningObjectiveStore.learningObjectives
        return evaluated_Objectives.isEmpty
    }
    
    func filterLearningObjective(filters : Dictionary<String, Array<String>>) -> [learning_Objective]{
        
        if filters.isEmpty {
            return learningObjectiveStore.learningObjectives
        }
        
        
        let return_Learning_Objectives = learningObjectiveStore.learningObjectives
            .filter({
                filters["Main"]!.contains("Core") ? $0.isCore :
                filters["Main"]!.contains("Elective") ? !$0.isCore :
                true
            })
            .filter ({
                filters["Strands"]!.count == 0 ? true : filters["Strands"]!.contains($0.strand)
            })
            .filter({
                if let first_Strand = filters["Path"]!.first {
                    if let path_Index = learningPathStore.learningPaths.firstIndex(where: {$0.title == first_Strand}) {
                        return (($0.core_Rubric_Levels[path_Index] * $0.core_Rubric_Levels[0] ) > 1)
                    }
                }
                return true
            })
            .filter({
                filters["Main"]!.contains("Evaluated") ? $0.eval_score.count > 0 :
                filters["Main"]!.contains("Not Evaluated") ? $0.eval_score.isEmpty :
                true
            })
        
        self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
        
        return return_Learning_Objectives
    }
    
}

