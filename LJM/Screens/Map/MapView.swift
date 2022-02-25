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
    
    @State private var searchText = ""
    @State private var selectedPath : String?
    
    @Binding var selectedFilters: Dictionary<String, Array<String>>
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var selectedSegmentView : SelectedSegmentView
    
    // new data flow
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    @Binding var toggleFilters: Bool
    // check if the filters was updated
    
    @State var isUpdated : Bool = false
    
    // filtered learning objectives
    
    @State var filtered_Learning_Objectives : [learning_Objective] = []
    @State var filters : Dictionary<String, Array<String>> = [:]
    @State var filter_Text = ""
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            ScrollViewReader { proxy in
                
                VStack(alignment: .leading) {
                    
                    TitleScreenView(title: "Map")
                    
                    DescriptionTitleScreenView(desc: "The Map provides access to all the current Learning Objectives in the Academy Curriculum. The Communal Learning Objectives will be adressed during the Challenges and added to your Journey. You can also explore and add Elective Learning Objectives based on your interests and the profile of specific career paths.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        
                        SearchBarExpandableJourney(txtSearchBar: $searchText, isUpdated: $isUpdated)
                        
                        Spacer()
                        HStack{
                            Text("Filters").font(.system(size: 20))
                            Image(systemName: toggleFilters ? "chevron.up" : "chevron.down")
                                .font(.system(size: 20))
                        }
                        .background(Color.gray.opacity(0.001))
                        .onTapGesture {
                            self.toggleFilters.toggle()
                        }
                    }.padding(.top, 10)
                    
                    Filters(
                        viewType: .map,
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
//                        .animation(.easeOut)
//                        .transition(.slide)
                        .onAppear {
                            selectedFilters = FiltersModel(viewType: .map).defaultFilters()
                            filters = selectedFilters
                            filtered_Learning_Objectives = filterLearningObjective()
                        }
                    
                    ZStack(alignment: .top) {
                        NumberTotalLearningObjectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                            .padding(.top, -10)
                        
                        Text("No learning objectives found ...")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.customDarkGrey)
                            .padding(.top, 75)
                            .isHidden(self.totalNumberLearningObjectivesStore.total == 0 ? false : true)
                        
                        ScrollViewLearningObjectives(learningPathSelected: $selectedPath, isAddable: true, isLearningGoalAdded: nil, textFromSearchBar: $searchText, filtered_Learning_Objectives: $filtered_Learning_Objectives)
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
                    withAnimation {
                        self.offset = element
                    }
                }
                .padding(.leading, 50).padding(.trailing, 50)
            }
        }
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
            self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
            return return_Learning_Objectives
            
        }
        
        let return_Learning_Objectives = learningObjectiveStore.learningObjectives
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
        
        self.totalNumberLearningObjectivesStore.total = return_Learning_Objectives.count
        
        return return_Learning_Objectives
    }
    
    //    func randomizeNewData(){
    //
    //        learningObjectiveStore.reset_Evaluated {
    //            print("done")
    //        }
    //        let tempdate1 = Date.parse("2021-01-01")
    //        let tempdate2 = Date.parse("2022-01-01")
    //        let date1 = Calendar.current.date(bySettingHour: 0, minute: 1, second: 0, of: tempdate1)!
    //        let date2 = Calendar.current.date(bySettingHour: 0, minute: 1, second: 0, of: tempdate2)!
    //        for _ in Range(0...30) {
    //            for LO_Index in learningObjectiveStore.learningObjectives.indices {
    //                learningObjectiveStore.evaluate_Object(index: LO_Index, evaluation: Int.random(in: Range(1...5)), date: Date.randomBetween(start: date1, end: date2))
    //            }
    //        }
    //    }
}

extension Date {
    
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> String {
        let date1 = Date.parse(start, format: format)
        let date2 = Date.parse(end, format: format)
        return Date.randomBetween(start: date1, end: date2).dateString(format)
    }
    
    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }
    
    func dateString(_ format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
        return date
    }
}
