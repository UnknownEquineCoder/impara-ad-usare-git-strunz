//
//  MyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct MyJourneyView: View {
    
    @Binding var offset: CGFloat
    
    @Binding var scrollTarget: Bool
        
    @State private var searchText = ""
    @State private var selectedPath : String?
    
    @Binding var selectedFilters: Dictionary<String, Array<String>>
    
    @Binding var selectedMenu: OutlineMenu
    
    @Environment(\.colorScheme) var colorScheme1
    
    // new data flow
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    // check if filter updating
    
    @State var filtered_Learning_Objectives : [learning_Objective] = []
    
    @State var isUpdated : Bool = false
    @Binding var toggleFilters: Bool
    @State var filters : Dictionary<String, Array<String>> = [:]
    @State var filter_Text = ""
    
    var body: some View {
        
        ZStack {
                        
            ScrollView(showsIndicators: false) {
                
                ScrollViewReader { proxy in
                    
                    VStack {
                        TitleScreenView(title: "Journey")
                        
                        VStack(alignment: .leading) {
                            DescriptionTitleScreenView(desc: "During your Journey, you will encounter a series of Learning Objectives (LOs). The Communal LOs will be added to your Journey as they are addressed in the Challenges. Elective Objectives will appear here when you select them from the Map. You can compare your Journey to specific career paths to help with personal planning. The arrows indicate your current progress towards reaching the LO.")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            SearchBarExpandableJourney(txtSearchBar: $searchText, isUpdated: $isUpdated)
                            
                            Spacer()
                            HStack {
                                Text("Filters").font(.system(size: 20))
                                Image(systemName: toggleFilters ? "chevron.up" : "chevron.down")
                                    .font(.system(size: 20))
                            }.onTapGesture {
                                self.toggleFilters.toggle()
                            }
                            .clipped()
                        }
                        
                        Filters(
                            viewType: .journey,
                            selectedFilters: $selectedFilters,
                            onFiltersChange: { filter in
                                filters = filter
                                filtered_Learning_Objectives = filterLearningObjective()
                            })
                            .opacity(toggleFilters ? 1 : 0)
                            .frame(height: toggleFilters ? .none : 0)
                            .clipped()
                            .padding(.top, toggleFilters ? 5 : 0)
                            .animation(.easeOut)
                            .transition(.slide)
                        
                        ZStack(alignment: .topLeading) {
                            
                            NumberTotalLearningObjectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                                .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)
                            
                            ListViewLearningObjectiveMyJourney(txtSearchBar: $searchText, selectedPath: $selectedPath, selectedMenu: $selectedMenu, filtered_Learning_Objectives: $filtered_Learning_Objectives)
                                .onAppear {
                                    filtered_Learning_Objectives = filterLearningObjective()
                                }
                                .onChange(of: scrollTarget) { target in
                                    withAnimation {
                                        proxy.scrollTo(0, anchor: .top)
                                    }
                                }
                                .onChange(of: learningObjectiveStore.learningObjectives) { learning_Objectives in
                                    filtered_Learning_Objectives = filterLearningObjective()
                                }
                                .onChange(of: searchText, perform: { newValue in
                                    filter_Text = newValue
                                    filtered_Learning_Objectives = filterLearningObjective()
                                })
                            
                                .padding(.top, 30)
                            
                        }.frame(maxWidth: .infinity)
                    }
                    .id(0)
                    .background(
                        GeometryReader {
                            Color.clear.preference(key: ViewOffsetKey2.self,
                                                   value: -$0.frame(in: .named("scroll")).origin.y)
                        }
                    )
                    .onPreferenceChange(ViewOffsetKey2.self) { element in
                        withAnimation {
                            offset = element
                        }
                    }
                    .padding(.leading, 50).padding(.trailing, 50)
                    .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)
                }
            }
        }
    }
    
    func checkIfMyJourneyIsEmpty() -> Bool {
        let evaluated_Objectives = self.learningObjectiveStore.learningObjectives.filter({!$0.eval_score.isEmpty})
        return evaluated_Objectives.isEmpty
    }
    
    func filterLearningObjective() -> [learning_Objective]{
        
        if filters.isEmpty {
            filtered_Learning_Objectives = learningObjectiveStore.learningObjectives
                .filter({!$0.eval_score.isEmpty})
                .filter({
                    filter_Text.isEmpty ||
                    $0.goal.lowercased().contains(filter_Text.lowercased()) ||
                    $0.description.lowercased().contains(filter_Text.lowercased()) ||
                    $0.Keyword.contains(where: {$0.lowercased().contains(filter_Text.lowercased())}) ||
                    $0.strand.lowercased().contains(filter_Text.lowercased()) ||
                    $0.goal_Short.lowercased().contains(filter_Text.lowercased()) ||
                    $0.ID.lowercased().contains(filter_Text.lowercased())
                })
            self.totalNumberLearningObjectivesStore.total = filtered_Learning_Objectives.count
            return filtered_Learning_Objectives
        }
        
        let return_Learning_Objectives = learningObjectiveStore.learningObjectives
            .filter({
                !$0.eval_score.isEmpty
            })
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
                filter_Text.isEmpty ||
                $0.goal.lowercased().contains(filter_Text.lowercased()) ||
                $0.description.lowercased().contains(filter_Text.lowercased()) ||
                $0.Keyword.contains(where: {$0.lowercased().contains(filter_Text.lowercased())}) ||
                $0.strand.lowercased().contains(filter_Text.lowercased()) ||
                $0.goal_Short.lowercased().contains(filter_Text.lowercased()) ||
                $0.ID.lowercased().contains(filter_Text.lowercased())
            })
        
        self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
        
        return return_Learning_Objectives
    }
}

struct ListViewLearningObjectiveMyJourney: View {
    
    @Binding var txtSearchBar : String
    @Binding var selectedPath : String?
    @Binding var selectedMenu: OutlineMenu
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    @Binding var filtered_Learning_Objectives : [learning_Objective]
    
    var body: some View {
        if !checkIfMyJourneyIsEmpty() {
            ZStack(alignment: .top) {
                
                Text("No learning objectives found ...")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customDarkGrey)
                    .padding(.top, 20)
                    .isHidden(self.totalNumberLearningObjectivesStore.total > 0 ? true : false)
                
                ScrollViewLearningObjectives(learningPathSelected: $selectedPath, isAddable: false, isLearningGoalAdded: nil, textFromSearchBar: $txtSearchBar, filtered_Learning_Objectives: $filtered_Learning_Objectives)
                
            }
        } else {
            EmptyLearningObjectiveViewJourney(selectedMenu: $selectedMenu)
        }
    }
    
    func checkIfMyJourneyIsEmpty() -> Bool {
        let evaluated_Objectives = self.learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0})
        return evaluated_Objectives.isEmpty
    }
}

struct ViewOffsetKey2: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
