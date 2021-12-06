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
    @State var filters : Dictionary<String, Array<String>> = [:]

    
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
                onFiltersChange: { filter in
                    filters = filter
                    filtered_Learning_Objectives = filterLearningObjective(filters: filter)
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
                
            ListViewLearningObjectiveMyJourney(selectedFilter: $selectedFilter, txtSearchBar: $searchText, selectedPath: $selectedPath, selectedStrands: $selectedStrands, selectedMenu: $selectedMenu, selectedSort: $selectedSort, filtered_Learning_Objectives: $filtered_Learning_Objectives)
                .onAppear(perform: {
                    filtered_Learning_Objectives = learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0})
                    self.totalNumberLearningObjectivesStore.total = filtered_Learning_Objectives.count
                })
                .onChange(of: learningObjectiveStore.learningObjectives) { learning_Objectives in
                    filtered_Learning_Objectives = filterLearningObjective(filters: filters)
                }
                    .padding(.top, 30)
                
        }.padding(.leading, 50).padding(.trailing, 50)
    }
    
    func checkIfMyJourneyIsEmpty() -> Bool {
        let evaluated_Objectives = self.learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0})
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
    
    @Binding var selectedFilter: CoreEnum.RawValue
    @Binding var txtSearchBar : String
    @Binding var selectedPath : String?
    @Binding var selectedStrands : [String]
    @Binding var selectedMenu: OutlineMenu
    @Binding var selectedSort: SortEnum?
    
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
                
//                ScrollViewLearningObjectives(learningPathSelected: $selectedPath, textFromSearchBar: $txtSearchBar, filtered_Learning_Objectives: $filtered_Learning_Objectives)
                
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
