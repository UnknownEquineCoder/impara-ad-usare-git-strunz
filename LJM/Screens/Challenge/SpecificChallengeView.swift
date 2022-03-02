//
//  SpecificChallengeView.swift
//  LJM
//
//  Created by denys pashkov on 16/02/22.
//

import SwiftUI

struct SpecificChallengeView: View {
    
    @State private var searchText = ""
    @State private var selectedFilters: Dictionary<String, Array<String>> = [:]
    @State var offset : CGFloat = 0
    
    @Binding var challenge : Challenge?
    @Binding var isViewSelected : Bool
    
    @AppStorage("fullScreen") var fullScreen: Bool = FullScreenSettings.fullScreen
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    @EnvironmentObject var learningPathStore : LearningPathStore
    let challenges : [Challenge]
    
    // check if filters was changed
    
    @State var isUpdated : Bool = false
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
                            
                            SearchBarExpandableJourney(txtSearchBar: $searchText, isUpdated: $isUpdated)
                            
                            Spacer()
                            HStack{
                                Text("Filter").font(.system(size: 20))
                                Image(systemName: toggleFilters ? "chevron.up" : "chevron.down")
                                    .font(.system(size: 20))
                            }.background(Color.gray.opacity(0.001))
                                .onTapGesture {
                                self.toggleFilters.toggle()
                            }
                        }.padding(.top, 10)
                            .onChange(of: isForceScrollUp) { target in
                                withAnimation {
                                    proxy.scrollTo(0, anchor: .top)
                                }
                            }
                        
                        Filters(
                            viewType: .challenge, challenges: challenges,
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
                                selectedFilters = FiltersModel(viewType: .map, challenges: []).defaultFilters()
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
                                .padding(.top, -10)
                            
                            Text("No learning objectives found ...")
                                .font(.system(size: 25, weight: .semibold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.customDarkGrey)
                                .padding(.top, 75)
                                .isHidden(self.totalNumberLearningObjectivesStore.total == 0 ? false : true)
                            
                            ScrollViewLearningObjectives(learningPathSelected:.constant(nil), isLearningGoalAdded: false, textFromSearchBar: $searchText, filtered_Learning_Objectives: $filtered_Learning_Objectives2)
                            
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
                            withAnimation {
                                self.offset = element
                                isFilterShown = element >= 175
                            }
                        }
                }.padding(.leading, 50).padding(.trailing, 50)
            }
            .padding(.top, fullScreen == true ? 60 : 0)
            
            
            VStack{
                TopbarWithBack(title: .constant(challenge!.name), filters: selectedFilters, scrollTarget: $isForceScrollUp, toggleFilters: $toggleFilters, isFilterShown: $isFilterShown, isViewSelected: $isViewSelected)
                
                Spacer()
            }
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
                $0.challengeID.contains(challenge!.ID)
            })
            .filter({
                filters["Main"]!.contains("Core") ? $0.isCore :
                filters["Main"]!.contains("Elective") ? !$0.isCore :
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
                if filters["Challenges"]!.contains("Any") {
                    return true
                } else {
                    return $0.challengeID.contains(filters["Challenges"]!.first!)
                }
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

//struct SpecificChallengeView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//            SpecificChallengeView(challenge: Challenge(name: "ASD",
//                                    description: "wevnskduvbwkdeh",
//                                    ID: "NS1",
//                                    start_Date: "11/12",
//                                    end_Date: "12/12",
//                                    LO_IDs: ["BUS06"]),
//                                    isViewSelected: .constant(false),
//                                    filtered_Learning_Objectives: [])
//    }
//}
