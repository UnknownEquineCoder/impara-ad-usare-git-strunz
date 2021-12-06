//
//  LearningGoalsView.swift
//  LJM
//
//  Created by Laura Benetti on 19/03/21.
//

import SwiftUI

struct LearningGoalsView: View {
    
    @State var selectedFilter = "ALL"
    @State var selectedFilterInsideButton = "All"
    @State private var searchText = ""
    @State private var selectedPath: String?
    @State private var added = false
    @State var selectedStrands = [String]()
    @State var selectedEvaluatedOrNotFilter: EvaluatedOrNotEnum?
    
    @Environment(\.colorScheme) var colorScheme
    var titleView: String

    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    @EnvironmentObject var learningPathStore : LearningPathStore
    
    // check if filters was changed
    
    @State var isUpdated : Bool = false
    var filtered_Learning_Objectives : [learning_Objective]
    @State var filtered_Learning_Objectives2 : [learning_Objective] = []
    @State var toggleFilters : Bool = false
    
    @State var filters : Dictionary<String, Array<String>> = [:]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                
                TitleScreenView(title: titleView)
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "Here you can take a look at all the Learning Objectives related to the Learning Goal you're looking at. Adding a Learning Objective to evaluate it will automatically add it to 'Journey' and mark it as checked in 'Map' as well.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }.frame(maxWidth: .infinity)
            
            HStack {
                
                SearchBarExpandableJourney(txtSearchBar: $searchText, isUpdated: $isUpdated)
                
                Spacer()
                HStack{
                    Text("Filter").font(.system(size: 20))
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
                    filtered_Learning_Objectives2 = filterLearningObjective(filters: filter)
                })
                .opacity(toggleFilters ? 1 : 0)
                .frame(height: toggleFilters ? .none : 0)
                .clipped()
                .animation(.easeOut)
                .transition(.slide)
            .onAppear {
                filtered_Learning_Objectives2 = filtered_Learning_Objectives
                self.totalNumberLearningObjectivesStore.total = filtered_Learning_Objectives2.count
            }
            .onChange(of: filtered_Learning_Objectives) { learning_Objectives in
                filtered_Learning_Objectives2 = filterLearningObjective(filters: filters)
            }
            
            ZStack(alignment: .top) {
                
                Text("\(self.totalNumberLearningObjectivesStore.total) Learning Objectives:")
                    .foregroundColor(Color.customDarkGrey)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("No learning objectives found ...")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customDarkGrey)
                    .padding(.top, 75)
                    .isHidden(self.totalNumberLearningObjectivesStore.total == 0 ? false : true)
                
                // TODO
                ScrollViewLearningObjectives(learningPathSelected: $selectedPath, isLearningGoalAdded: false, textFromSearchBar: $searchText, filtered_Learning_Objectives: .constant(filtered_Learning_Objectives))
                    .padding(.top, 50)
                
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
        
    }
    
    func filterLearningObjective(filters : Dictionary<String, Array<String>>) -> [learning_Objective]{
        
        if filters.isEmpty {
            return filtered_Learning_Objectives
        }
        
        let return_Learning_Objectives = filtered_Learning_Objectives
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
