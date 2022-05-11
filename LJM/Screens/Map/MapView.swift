//
//  PathsView.swift
//  LJM
//
//  Created by Laura Benetti on 28/11/2020.
//

import SwiftUI

struct MapView: View {
    
    @AppStorage("fullScreen") var fullScreen: Bool = FullScreenSettings.fullScreen
    
    @Binding var offset : CGFloat
    @Binding var scrollTarget: Bool
    @Binding var selectedFilters: Dictionary<String, Array<String>>
    @Binding var toggleFilters: Bool
    
    @State private var searchText = ""
    @State private var selectedPath : String?
    
    // filtered learning objectives
    
    @State var filtered_Learning_Objectives : [learning_Objective] = []
    @State var filters : Dictionary<String, Array<String>> = [:]
    @State var filter_Text = ""
    
    @Environment(\.colorScheme) var colorScheme
            
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    var body: some View {
        ZStack{
            Color.bgColor
                .padding(.top, -40)
                .padding(.leading, -10)
            
            ScrollView(showsIndicators: false) {
                
                ScrollViewReader { proxy in
                    
                    VStack(alignment: .leading) {
                        
                        TitleScreenView(title: "Map")
                        
                        DescriptionTitleScreenView(desc: "The Map provides access to all the current Learning Objectives in the Academy Curriculum. The Communal Learning Objectives will be adressed during the Challenges and added to your Journey. You can also explore and add Elective Learning Objectives based on your interests and the profile of specific career paths.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            
                            SearchBarExpandableJourney(txtSearchBar: $searchText)
                            
                            Spacer()
                            
                            HStack{
                                Text("Filters \(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count == nil || getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count == 0 ? "" : "(\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count != 1 ? ("\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).count)") : "\(getNumberOfFilters(filters: filters.filter{$0.value != ["Any"] && $0.value != ["Name"]}).first ?? "")"))")")
                                    .font(.system(size: 20))
                                Image(systemName: toggleFilters ? "chevron.up" : "chevron.down")
                                    .font(.system(size: 20))
                            }
                            .background(Color.gray.opacity(0.001))
                            .onTapGesture {
                                self.toggleFilters.toggle()
                            }
                        }.padding(.top, 10)
                        
                        Filters(
                            viewType: .map, challenges: learningObjectiveStore.getChallenges(),
                            selectedFilters: $selectedFilters,
                            onFiltersChange: { filter in
                                filters = filter
                                selectedFilters = filter
                                filtered_Learning_Objectives = filterLearningObjective()
                            })
                            .opacity(toggleFilters ? 1 : 0)
                            .frame(height: toggleFilters ? .none : 0)
                            .clipped()
                            .padding(.top, toggleFilters ? 5 : 0)
                            .onAppear {
                                selectedFilters = FiltersModel(viewType: .map, challenges: learningObjectiveStore.getChallenges().map({
                                    $0.ID
                                })).defaultFilters()
                                filters = selectedFilters
                                filtered_Learning_Objectives = filterLearningObjective()
                            }
                        
                        ZStack(alignment: .top) {
                            NumberTotalLearningObjectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                                .padding(.top, -10)
                            
                            Text("No learning objectives found.")
                                .font(.system(size: 25, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.customDarkGrey)
                                .padding(.top, 75)
                                .isHidden(self.totalNumberLearningObjectivesStore.total == 0 ? false : true)
                            
                            ScrollViewLearningObjectives(learningPathSelected: selectedFilters["Path"]?.first, isAddable: true, isLearningGoalAdded: nil, textFromSearchBar: $searchText, filtered_Learning_Objectives: $filtered_Learning_Objectives)
                                .onAppear {
                                    filtered_Learning_Objectives = filterLearningObjective()
                                }
                                .onChange(of: scrollTarget) { target in
                                        proxy.scrollTo(0, anchor: .top)
                                }
                                .onChange(of: learningObjectiveStore.learningObjectives) { learning_Objectives in
                                    filtered_Learning_Objectives = filterLearningObjective()
                                }
                                .onChange(of: searchText) { newValue in
                                    filter_Text = newValue
                                    filtered_Learning_Objectives = filterLearningObjective()
                                }
                            
                        }
                    }
                    .padding(.top, fullScreen == true ? 60 : 0)
                    .id(0)
                    .background(
                        GeometryReader {
                            Color.clear.preference(key: ViewOffsetKey2.self,
                                                   value: -$0.frame(in: .named("scroll")).origin.y)
                        }
                    )
                    .onPreferenceChange(ViewOffsetKey2.self) { element in
                        withAnimation(.linear(duration: 0.1), {
                            self.offset = element
                        })
                    }
                    .padding(.leading, 50).padding(.trailing, 50)
                }
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
    
    func filterLearningObjective() -> [learning_Objective]{
        if filters.isEmpty {
            let return_Learning_Objectives = learningObjectiveStore.learningObjectives.filter({
                filter_Text.isEmpty ||
                $0.goal.lowercased().contains(filter_Text.lowercased()) ||
                $0.description.lowercased().contains(filter_Text.lowercased()) ||
                $0.Keyword.contains(where: {$0.lowercased().contains(filter_Text.lowercased())}) ||
                $0.strand.lowercased().contains(filter_Text.lowercased()) ||
                $0.goal_Short.lowercased().contains(filter_Text.lowercased()) ||
                $0.ID.lowercased().contains(filter_Text.lowercased())
            })
                .sorted {
                    $0.ID < $1.ID
                }
            
            self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
            return return_Learning_Objectives
            
        }
        
        let return_Learning_Objectives = learningObjectiveStore.learningObjectives
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
                if filters["Challenge"]!.contains("Any") {
                    return true
                } else {
                    return $0.challengeID.contains(filters["Challenge"]!.first!)
                }
            })
            .filter({
                filters["Status"]!.contains("Evaluated") ? $0.eval_score.count > 0 :
                filters["Status"]!.contains("Not Evaluated") ? $0.eval_score.isEmpty :
                true
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
            .sorted {
                $0.ID < $1.ID
            }
        
        self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
        
        return return_Learning_Objectives
    }
}
