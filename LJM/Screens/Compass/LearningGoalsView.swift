//
//  LearningGoalsView.swift
//  LJM
//
//  Created by Laura Benetti on 19/03/21.
//

import SwiftUI
import AppKit

struct LearningGoalsView: View {
    
    @AppStorage("fullScreen") var fullScreen: Bool = FullScreenSettings.fullScreen
    
    @State private var searchText = ""
    @State private var selectedPath: String?
    @State private var added = false
    
    
    @State private var selectedFilters: Dictionary<String, Array<String>> = [:]
    
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
        
        ZStack {
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            DescriptionTitleScreenView(desc: "Here you can take a look at all the Learning Objectives related to the Learning Goal you're looking at. Adding a Learning Objective to evaluate it will automatically add it to 'Journey' and mark it as checked in 'Map' as well.")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        
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
                        selectedFilters: $selectedFilters,
                        onFiltersChange: { filter in
                            filters = filter
                            filtered_Learning_Objectives2 = filterLearningObjective()
                        })
                        .opacity(toggleFilters ? 1 : 0)
                        .frame(height: toggleFilters ? .none : 0)
                        .clipped()
                        .padding(.top, toggleFilters ? 5 : 0)
                        .animation(.easeOut)
                        .transition(.slide)
                        .onAppear {
                            filtered_Learning_Objectives2 = filtered_Learning_Objectives
                            self.totalNumberLearningObjectivesStore.total = filtered_Learning_Objectives2.count
                        }
                        .onChange(of: filtered_Learning_Objectives) { learning_Objectives in
                            filtered_Learning_Objectives2 = filterLearningObjective()
                        }
                        .onChange(of: searchText) { _ in
                            filtered_Learning_Objectives2 = filterLearningObjective()
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
                        ScrollViewLearningObjectives(learningPathSelected: $selectedPath, isLearningGoalAdded: false, textFromSearchBar: $searchText, filtered_Learning_Objectives: $filtered_Learning_Objectives2)
                            .padding(.top, 30)
                        
                    }.frame(maxWidth: .infinity)
                    
                }.padding(.leading, 50).padding(.trailing, 50)
            }.frame(maxWidth: .infinity)
        
        }
        
    }
    
    func filterLearningObjective() -> [learning_Objective]{
        
        if filters.isEmpty {
            let return_Learning_Objectives = filtered_Learning_Objectives
                .filter({
                    searchText.isEmpty ||
                    $0.goal.lowercased().contains(searchText.lowercased()) ||
                    $0.description.lowercased().contains(searchText.lowercased()) ||
                    $0.Keyword.contains(where: {$0.lowercased().contains(searchText.lowercased())}) ||
                    $0.strand.lowercased().contains(searchText.lowercased()) ||
                    $0.goal_Short.lowercased().contains(searchText.lowercased()) ||
                    $0.ID.lowercased().contains(searchText.lowercased())
                })
            self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
            return return_Learning_Objectives
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
                filters["Status"]!.contains("Evaluated") ? $0.eval_score.count > 0 :
                filters["Status"]!.contains("Not Evaluated") ? $0.eval_score.isEmpty :
                true
            })
            .filter({
                searchText.isEmpty ||
                $0.goal.lowercased().contains(searchText.lowercased()) ||
                $0.description.lowercased().contains(searchText.lowercased()) ||
                $0.Keyword.contains(where: {$0.lowercased().contains(searchText.lowercased())}) ||
                $0.strand.lowercased().contains(searchText.lowercased()) ||
                $0.goal_Short.lowercased().contains(searchText.lowercased()) ||
                $0.ID.lowercased().contains(searchText.lowercased())
            })
        
        self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
        
        return return_Learning_Objectives
    }
    
}
