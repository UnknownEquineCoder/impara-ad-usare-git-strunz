//
//  LearningGoalsView.swift
//  LJM
//
//  Created by Laura Benetti on 19/03/21.
//

import SwiftUI
import AppKit

struct LearningGoalsView: View {
    
    @State private var searchText = ""
    @State private var selectedFilters: Dictionary<String, Array<String>> = [:]
    @State var offset : CGFloat = 0
    
    @AppStorage("fullScreen") var fullScreen: Bool = FullScreenSettings.fullScreen
    @Environment(\.colorScheme) var colorScheme
    @Binding var titleView: String?
    
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    @EnvironmentObject var learningPathStore : LearningPathStore
    
    var filter_Path : String?
    let challenges : [Challenge]
    
    
    // check if filters was changed
    
    var filtered_Learning_Objectives : [learning_Objective]
    @State var filtered_Learning_Objectives2 : [learning_Objective] = []
    @State var toggleFilters : Bool = false
    
    @State var filters : Dictionary<String, Array<String>> = [:]
    
    @State var isFilterShown : Bool = true
    @State var isForceScrollUp : Bool = false
    
    var body: some View {
        ZStack{
            
            ScrollView(showsIndicators: false) {
                ScrollViewReader { proxy in
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            
                            SearchBarExpandableJourney(txtSearchBar: $searchText)
                            
                            Spacer()
                            HStack{
                                Text("Filters \(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count == 0 || getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count == 0 ? "" : "(\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count != 1 ? ("\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count)") : "\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).first ?? "")"))")").font(.system(size: 20))
                                Image(systemName: toggleFilters ? "chevron.up" : "chevron.down")
                                    .font(.system(size: 20))
                            }
                            .background(Color.gray.opacity(0.001))
                            .onTapGesture {
                                self.toggleFilters.toggle()
                            }
                            
                        }
                        .padding(.top,10)
                        
                        Filters(
                            viewType: .map, challenges: challenges,
                            selectedFilters: $selectedFilters,
                            onFiltersChange: { filter in
                                filters = filter
                                selectedFilters = filter
                                filtered_Learning_Objectives2 = filterLearningObjective(LO: filtered_Learning_Objectives)
                            })
                            .opacity(toggleFilters ? 1 : 0)
                            .frame(height: toggleFilters ? .none : 0)
                            .clipped()
                            .padding(.top, toggleFilters ? 5 : 0)
                            .onAppear {
                                selectedFilters = FiltersModel(viewType: .map, challenges: challenges.map({
                                    $0.ID
                                })).defaultFilters()
                                filtered_Learning_Objectives2 = filterLearningObjective(LO: filtered_Learning_Objectives)
                                self.totalNumberLearningObjectivesStore.total = filtered_Learning_Objectives2.count
                            }
                            .onChange(of: filtered_Learning_Objectives) { learning_Objectives in
                                filtered_Learning_Objectives2 = filterLearningObjective(LO: learning_Objectives)
                            }
                            .onChange(of: searchText) { _ in
                                filtered_Learning_Objectives2 = filterLearningObjective(LO: filtered_Learning_Objectives)
                            }
                        
                        ZStack(alignment: .top) {
                            
                            Text("\(self.totalNumberLearningObjectivesStore.total) Learning Objectives:")
                                .foregroundColor(Color.customDarkGrey)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, -10)
                            
                            Text("No learning objectives found.")
                                .font(.system(size: 25, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.customDarkGrey)
                                .padding(.top, 75)
                                .isHidden(self.totalNumberLearningObjectivesStore.total == 0 ? false : true)
                            
                            ScrollViewLearningObjectives(learningPathSelected: selectedFilters["Path"]?.first, isLearningGoalAdded: false, textFromSearchBar: $searchText, filtered_Learning_Objectives: $filtered_Learning_Objectives2)
                            
                        }.frame(maxWidth: .infinity)
                    }
                    .padding(.top,fullScreen == true ? 20 : 35)
                    .id(0)
                    .frame(maxWidth: .infinity)
                        .background(
                            GeometryReader {
                                Color.clear.preference(key: ViewOffsetKey2.self,
                                                       value: -$0.frame(in: .named("scroll")).origin.y)
                            }
                        )
                        .onPreferenceChange(ViewOffsetKey2.self) { element in
                            withAnimation(.linear(duration: 0.1)) {
                                self.offset = element
                                isFilterShown = element >= 175
                            }
                        }
                }.padding(.leading, 50).padding(.trailing, 50)
            }
            .padding(.top, fullScreen == true ? 60 : 20)
            
            
            VStack {
                TopbarWithBack(title: $titleView, filters: selectedFilters, scrollTarget: $isForceScrollUp, toggleFilters: $toggleFilters, isFilterShown: $isFilterShown, isViewSelected: .constant(false))
                
                Spacer()
            }
        }  
    }
    
    func getNumberOfFilters(filters: Dictionary<String, Array<String>>) -> [String] {
        
        let values = filters.map {$0.value}
        var arrayValues = [String]()
        
        for value in values {
            arrayValues.append(contentsOf: value)
        }
                
        return arrayValues
    }
    
    func filterLearningObjective(LO: [learning_Objective]) -> [learning_Objective]{
        
        if filters.isEmpty {
            let return_Learning_Objectives = LO
                .filter({
                    searchText.isEmpty ||
                    $0.goal.lowercased().contains(searchText.lowercased()) ||
                    $0.description.lowercased().contains(searchText.lowercased()) ||
                    $0.Keyword.contains(where: {$0.lowercased().contains(searchText.lowercased())}) ||
                    $0.strand.lowercased().contains(searchText.lowercased()) ||
                    $0.goal_Short.lowercased().contains(searchText.lowercased()) ||
                    $0.ID.lowercased().contains(searchText.lowercased())
                })
                .sorted {
                    $0.ID < $1.ID
                }
            self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
            return return_Learning_Objectives
        }
        
        let return_Learning_Objectives = LO
            .filter({
                filters["Type"]!.contains("Core") ? $0.isCore :
                filters["Type"]!.contains("Elective") ? !$0.isCore :
                true
            })
            .filter ({
                if filters["Strand"]!.contains("Any") {
                    return true
                }
                return filters["Strand"]!.count == 0 ? true : filters["Strand"]!.contains($0.strand)
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
                if filters["Challenge"]!.contains("Any") {
                    return true
                } else {
                    return $0.challengeID.contains(filters["Challenge"]!.first!)
                }
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
            .sorted {
                $0.ID < $1.ID
            }
        
        self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
        
        return return_Learning_Objectives
    }
    
}

struct LearningGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        LearningGoalsView(titleView: .constant("ASD"), filter_Path: "", challenges: [], filtered_Learning_Objectives: [])
    }
}
