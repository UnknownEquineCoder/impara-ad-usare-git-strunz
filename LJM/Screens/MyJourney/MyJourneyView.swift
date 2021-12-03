//
//  MyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct MyJourneyView: View {
    
    @State var selectedFilter = "ALL"
    @State var selectedFilterInsideButton = "All"
    @State var selectedStrands = [String]()
    @State var selectedSort : SortEnum?
    @State var selectedEvaluatedOrNotFilter: EvaluatedOrNotEnum?
    
    let arrayFilters = ["All", "Core", "Elective", "Evaluated", "Not Evaluated"]
    
    @State private var searchText = ""
    @State private var selectedPath : String?
    
    @Binding var selectedMenu: OutlineMenu
    
    @Environment(\.colorScheme) var colorScheme1
    
    // new data flow
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    // check if filter updating
    
    @State var isUpdated : Bool = false
    @State private var toggleFilters: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .topLeading) {
                    
                    TitleScreenView(title: "Journey")
                    
                    VStack(alignment: .leading) {
                        DescriptionTitleScreenView(desc: "During your Journey, you will encounter a series of Learning Objectives (LOs). The Communal LOs will be added to your Journey as they are addressed in the Challenges. Elective Objectives will appear here when you select them from the Map. You can compare your Journey to specific career paths to help with personal planning. The arrows indicate your current progress towards reaching the LO.")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 50)
                    
                }.frame(maxWidth: .infinity)
                .padding(.top, 40)
                
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
                .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)
                
                Filters(
                    onFiltersChange: { filters in
                        print("Filters Updated")
                        print(filters)
                    })
                    .opacity(toggleFilters ? 1 : 0)
                    .frame(height: toggleFilters ? .none : 0)
                    .clipped()
                    .animation(.easeOut)
                    .transition(.slide)
                
                ZStack(alignment: .topLeading) {
                    
                    NumberTotalLearningOjbectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                        .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)
                    
                    ListViewLearningObjectiveMyJourney(selectedFilter: $selectedFilter, txtSearchBar: $searchText, selectedPath: $selectedPath, selectedStrands: $selectedStrands, selectedMenu: $selectedMenu, selectedSort: $selectedSort)
                        .padding(.top, 30)
                    
                }.frame(maxWidth: .infinity)
            }
            .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)
            
            Filters(
                viewType: .journey,
                onFiltersChange: { filters in
                    print("Filters Updated")
                    print(filters)
                })
                .opacity(toggleFilters ? 1 : 0)
                .frame(height: toggleFilters ? .none : 0)
                .clipped()
                .animation(.easeOut)
                .transition(.slide)

                
                NumberTotalLearningOjbectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                    .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)

//                DropDownMenuSelectPath(selectedPath: $selectedPath)
//                    .frame(maxWidth: .infinity,  alignment: .trailing)
//                    .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)
                
                ListViewLearningObjectiveMyJourney(selectedFilter: $selectedFilter, txtSearchBar: $searchText, selectedPath: $selectedPath, selectedStrands: $selectedStrands, selectedMenu: $selectedMenu, selectedSort: $selectedSort)
                    .padding(.top, 30)
                
        }.padding(.leading, 50).padding(.trailing, 50)
    }
    
    func checkIfMyJourneyIsEmpty() -> Bool {
        let evaluated_Objectives = self.learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0})
        return evaluated_Objectives.isEmpty
    }
}

struct ListViewLearningObjectiveMyJourney: View {
    
    @Binding var selectedFilter: CoreEnum.RawValue
    @Binding var txtSearchBar : String
    @Binding var selectedPath : String?
    @Binding var selectedStrands : [String]
    @Binding var selectedMenu: OutlineMenu
    @Binding var selectedSort: SortEnum?
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    var body: some View {
        if !checkIfMyJourneyIsEmpty() {
            ZStack(alignment: .top) {
                
                Text("No learning objectives found ...")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customDarkGrey)
                    .padding(.top, 20)
                    .isHidden(self.totalNumberLearningObjectivesStore.total > 0 ? true : false)
                
                ScrollViewLearningObjectives(learningPathSelected: $selectedPath, filterCore: selectedFilter, filterSort: selectedSort, isAddable: false, isLearningGoalAdded: nil, textFromSearchBar: $txtSearchBar, selectedStrands: selectedStrands)
                
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
