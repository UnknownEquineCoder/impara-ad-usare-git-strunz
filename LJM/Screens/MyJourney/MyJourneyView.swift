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
    
    @State var filtered_Learning_Objectives : [learning_Objective] = []
    
    @State var isUpdated : Bool = false
    @State private var toggleFilters: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                
                TitleScreenView(title: "Journey")
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "During your Journey, you will encounter a series of Learning Objectives (LOs). The Communal LOs will be added to your Journey as they are addressed in the Challenges. Elective Objectives will appear here when you select them from the Map. You can compare your Journey to specific career paths to help with personal planning. The arrows indicate your current progress towards reaching the LO.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                
            }.frame(maxWidth: .infinity)
            
            HStack {
                
//                SortButtonMenu(selectedSort: $selectedSort).cursor(.pointingHand)
//                ContextMenuFilters(fromMap: false, fromCompass: false, selectedFilter: $selectedFilter, selectedPath: $selectedPath, selectedStrands: $selectedStrands, selectedEvaluatedOrNotFilter: $selectedEvaluatedOrNotFilter).cursor(.pointingHand)
//                DropDownMenuSort()
//                    .buttonStyle(PlainButtonStyle())
                
//                DropDownMenuFilters(selectedStrands: $selectedStrands, filterOptions: strandsStore.arrayStrandsFilter)
//                    .buttonStyle(PlainButtonStyle())
                
                SearchBarExpandableJourney(txtSearchBar: $searchText, isUpdated: $isUpdated)
//                    .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .red)
                
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
                viewType: .journey,
                onFiltersChange: { filters in
                    print("Filters Updated")
                    print(filters)
                    filtered_Learning_Objectives = filterLearningObjective(filters: filters)
                })
                .opacity(toggleFilters ? 1 : 0)
                .frame(height: toggleFilters ? .none : 0)
                .clipped()
                .animation(.easeOut)
                .transition(.slide)

                
                NumberTotalLearningOjbectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                    .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)

            ListViewLearningObjectiveMyJourney(txtSearchBar: $searchText, selectedMenu: $selectedMenu, filtered_Learning_Objectives: $filtered_Learning_Objectives, selectedPath: $selectedPath)
                    .padding(.top, 30)
                
        }.padding(.leading, 50).padding(.trailing, 50)
    }
    
    func checkIfMyJourneyIsEmpty() -> Bool {
        let evaluated_Objectives = self.learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0})
        return evaluated_Objectives.isEmpty
    }
    
    func filterLearningObjective(filters : Dictionary<String, Array<String>>) -> [learning_Objective]{
        
        let return_Learning_Objectives = learningObjectiveStore.learningObjectives.filter({
            var path_Index : Int? = nil
            if let first_Strand = filters["Strands"]!.first {
                path_Index = learningPathStore.learningPaths.firstIndex(where: {$0.title == first_Strand})
            }
             
            // parentesis for not breaking anithing, if you delete the parentesis it does not work because false && false && true && true is a true and not a false
            
            return (
                // check if the learning objective had been evaluated ( for the map view )
//                !$0.eval_score.isEmpty
                // filter for all/core/elective
                
                /// ["Main": [], "Sort by": [], "Path": [], "Strands": ["Design"]]
                (
                    (
                        filters["Main"]!.contains("Core") ? $0.isCore :
                        filters["Main"]!.contains("Elective") ? !$0.isCore :
                        true
                    )
    //                // filter for the searchbar /// Not present now inside the filters
//                    && (
//                        searchText.isEmpty ||
//                        $0.goal.lowercased().contains(searchText.lowercased()) ||
//                        $0.description.lowercased().contains(searchText.lowercased()) ||
//                        $0.Keyword.contains(where: {$0.lowercased().contains(searchText.lowercased())}) ||
//                        $0.strand.lowercased().contains(searchText.lowercased()) ||
//                        $0.goal_Short.lowercased().contains(searchText.lowercased()) ||
//                        $0.ID.lowercased().contains(searchText.lowercased())
//                    )
                )
                && (
                    (
                        // filter for strands
                        filters["Strans"]!.count == 0 ? true : selectedStrands.contains($0.strand)
    //
                    )
                    && (
                        // filter for path
                        (path_Index == nil) ? true : (($0.core_Rubric_Levels[path_Index ?? 0] * $0.core_Rubric_Levels[0] ) > 1)
                    )
                    && (
                        // filter if an element was alredy evaluated or not
                        filters["Main"]!.contains("Evaluated") ? $0.eval_score.count > 0 :
                        filters["Main"]!.contains("Not Evaluated") ? $0.eval_score.isEmpty :
                        true
//                        selectedEvaluatedOrNotFilter == nil ? true : selectedEvaluatedOrNotFilter == .evaluated ? $0.eval_score.count > 0 : $0.eval_score.isEmpty
                    )
                )
            )
        })
        
        return return_Learning_Objectives
    }
}

struct ScrollViewFiltersJourney: View {
    var filterTabs : [String]
    @Binding var selectedFilter : String
    @StateObject var vm = ScrollToModel()
    
    var body: some View {
        HStack {
            ArrowButtonScrollView(vm: vm, direction: .left)
                .buttonStyle(PlainButtonStyle())
                .opacity(filterTabs.count > 8 ? 1 : 0).cursor(.pointingHand)
            
            ScrollViewFilters(filterTabs: filterTabs, selectedFilter: $selectedFilter, vm: vm)
                .offset(x: filterTabs.count < 8 ? -35 : 0).cursor(.pointingHand)
            
            ArrowButtonScrollView(vm: vm, direction: .right)
                .buttonStyle(PlainButtonStyle())
                .opacity(filterTabs.count > 8 ? 1 : 0).cursor(.pointingHand)
        }
    }
}

struct ListViewLearningObjectiveMyJourney: View {
    
    @Binding var txtSearchBar : String
    @Binding var selectedMenu: OutlineMenu
    @Binding var filtered_Learning_Objectives : [learning_Objective]
    @Binding var selectedPath : String?
    
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
                
                ScrollViewLearningObjectives(learningPathSelected: $selectedPath, filtered_Learning_Objectives: $filtered_Learning_Objectives, textFromSearchBar: $txtSearchBar)
                
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

class ScrollToModel: ObservableObject {
    enum Action {
        case left
        case right
    }
    @Published var direction: Action? = nil
}
