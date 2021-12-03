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
    @State private var selectedPath : String?
    @State var selectedEvaluatedOrNotFilter: EvaluatedOrNotEnum?
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var selectedSegmentView : SelectedSegmentView
    
    // new data flow
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    // check if the filters was updated
    
    @State var isUpdated : Bool = false
    
    // filtered learning objectives
    
    @State var filtered_Learning_Objectives : [learning_Objective] = []
    
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                
                ScrollView(showsIndicators: false) {
                    
                    ZStack(alignment: .topLeading) {
                        
                        TitleScreenView(title: "Map")
                        
                        VStack(alignment: .leading) {
                            DescriptionTitleScreenView(desc: "The Map provides access to all the current Learning Objectives in the Academy Curriculum. The Communal Learning Objectives will be adressed during the Challenges and added to your Journey. You can also explore and add Elective Learning Objectives based on your interests and the profile of specific career paths.")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 50)
                        
                    }.frame(maxWidth: .infinity)
                        .padding(.top, 40)
                    
                    HStack {
                        ContextMenuFilters(fromMap: true, fromCompass: false, isUpdated: $isUpdated, selectedFilter: $selectedFilter, selectedPath: $selectedPath, selectedStrands: $selectedStrands, selectedEvaluatedOrNotFilter: $selectedEvaluatedOrNotFilter).cursor(.pointingHand)
                        
                        SearchBarExpandableJourney(txtSearchBar: $searchText, isUpdated: $isUpdated)
                        
                    }
                    
                    ZStack(alignment: .top) {
                        NumberTotalLearningOjbectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                        
                        Text("No learning objectives found ...")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.customDarkGrey)
                            .padding(.top, 75)
                            .isHidden(self.totalNumberLearningObjectivesStore.total == 0 ? false : true)
                        
                        ScrollViewLearningObjectives(learningPathSelected: $selectedPath, filteredMap: selectedFilter, filterLearningGoal: nil, filterEvaluatedOrNot: selectedEvaluatedOrNotFilter, isAddable: true, isLearningGoalAdded: nil, textFromSearchBar: $searchText, selectedStrands: selectedStrands)
                            .padding(.top, 30)
                        
                        GeometryReader { proxy in
                            let offset = proxy.frame(in: .named("scroll")).minY
                            Color.clear.preference(key: ViewOffsetKey.self, value: offset)
                        }
                        
                    }.padding(.top, 10)
                    
                    Spacer()
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ViewOffsetKey.self) { print("offset >> \($0)") }

                .onChange(of: isUpdated) { newValue in
                    filterLearningObjective()
                }
            }
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
        let evaluated_Objectives = self.learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0})
        return evaluated_Objectives.isEmpty
    }
    
    func filterLearningObjective(){
        
        filtered_Learning_Objectives = learningObjectiveStore.learningObjectives.filter({
            let path_Index = learningPathStore.learningPaths.firstIndex(where: {$0.title == selectedPath})
            // parentesis for not breaking anithing, if you delete the parentesis it does not work because false && false && true && true is a true and not a false
            return (
                // check if the learning objective had been evaluated ( for the map view )
                //                !$0.eval_score.isEmpty
                // filter for all/core/elective
                (
                    (
                        selectedFilter == "CORE" ? $0.isCore :
                            selectedFilter == "ELECTIVE" ? !$0.isCore :
                            true
                    )
                    //                // filter for the searchbar
                    && (
                        searchText.isEmpty ||
                        $0.goal.lowercased().contains(searchText.lowercased()) ||
                        $0.description.lowercased().contains(searchText.lowercased()) ||
                        $0.Keyword.contains(where: {$0.lowercased().contains(searchText.lowercased())}) ||
                        $0.strand.lowercased().contains(searchText.lowercased()) ||
                        $0.goal_Short.lowercased().contains(searchText.lowercased()) ||
                        $0.ID.lowercased().contains(searchText.lowercased())
                    )
                )
                && (
                    (
                        // filter for strands
                        selectedStrands.count == 0 ? true : selectedStrands.contains($0.strand)
                        //
                    )
                    && (
                        // filter for path
                        (path_Index == nil) ? true : (($0.core_Rubric_Levels[path_Index ?? 0] * $0.core_Rubric_Levels[0] ) > 1)
                    )
                    && (
                        // filter if an element was alredy evaluated or not
                        selectedEvaluatedOrNotFilter == nil ? true : selectedEvaluatedOrNotFilter == .evaluated ? $0.eval_score.count > 0 : $0.eval_score.isEmpty
                    )
                )
            )
        })
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
