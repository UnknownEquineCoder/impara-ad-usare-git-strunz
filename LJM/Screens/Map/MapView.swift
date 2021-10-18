//
//  PathsView.swift
//  LJM
//
//  Created by Laura Benetti on 28/11/2020.
//

import SwiftUI

struct MapView: View {
    @State var selectedFilter = "FULL MAP"
    @State var selectedStrands = [String]()
    @State var expand: Bool = false
    @State private var searchText = ""
    @State var selectedSort = ""
    
    var filterTabsMap = ["FULL MAP", "COMMUNAL", "ELECTIVE"]
    var fakePathsObjectArray : [learning_Path] = []
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var selectedSegmentView : SelectedSegmentView
    
    // new data flow
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    TitleScreenView(title: "Map")
                    
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "The Map provides access to all the current Learning Objectives in the Academy Curriculum. The Communal Learning Objectives will be adressed during the Challenges and added to your Journey. You can also explore and add Elective Learning Objectives based on your interests and the profile of specific career paths.")
                }
                
                HStack {
                    Text("Views")
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 20))
                    ScrollViewFilters(filterTabs: self.filterTabsMap, selectedFilter: $selectedFilter, vm: ScrollToModel())
                    //                            .padding(.top, 20)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .padding(.leading, 10)
                }
                
                HStack{
                    
                    Text("Paths")
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 20))
                    
                    ScrollViewFilters(filterTabs: getLearningPath(learningPaths: learningPathStore.learningPaths), selectedFilter: $selectedFilter, vm: ScrollToModel())
                        .padding(.leading, 10)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                }
                
                HStack {
                    DropDownMenuSort()
                        .buttonStyle(PlainButtonStyle())
                    
                    DropDownMenuFilters(selectedStrands: $selectedStrands, filterOptions: strandsStore.arrayStrandsFilter)
                        .buttonStyle(PlainButtonStyle())
                    
                    SearchBarExpandableJourney(txtSearchBar: $searchText)
                        .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                }
                
                ZStack(alignment: .top) {
                    NumberTotalLearningOjbectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                    
                    Text("No learning objectives found ...")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.customDarkGrey)
                        .padding(.top, 75)
                        .isHidden(self.totalNumberLearningObjectivesStore.total == 0 ? false : true)
                    
                    ScrollViewLearningObjectives(learningPathSelected: Binding.constant(nil), filteredMap: selectedFilter, isAddable: true, textFromSearchBar: searchText, selectedStrands: selectedStrands).padding(.top, 40).padding(.bottom, 50)
                    
                }.padding(.top, 10)
                
                Spacer()
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
}


//struct ScrollViewFiltersPaths: View {
//    @State var filterTabs = ["FRONT-END", "BACK-END","BUSINESS", "UI/UX", "GAME"]
//    @Binding var selectedFilter : String
//
//    @StateObject var vm = ScrollToModel()
//
//    var body: some View {
//        HStack {
//
//            ScrollView(.horizontal, showsIndicators: false) {
//
//                ScrollViewReader { (proxy: ScrollViewProxy) in
//                    LazyHStack {
//                        HStack(spacing: 10) {
//                            ForEach(filterTabs, id: \.self) { i in
//
//                                Button(action: {
//                                    self.selectedFilter = i
//                                }) {
//                                    Text(i)
//                                        .font(.system(size: 13, weight: .semibold, design: .rounded))
//                                        .foregroundColor(self.selectedFilter == i ? .white : .gray)
//                                }.buttonStyle(PlainButtonStyle())
//                                .frame(width: 150, height: 40)
//                                .background(self.selectedFilter == i ? Color("customCyan") : .white)
//                                .cornerRadius(12)
//                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).foregroundColor(self.selectedFilter == i ? .clear : .gray))
//                            }
//                        }.padding([.leading, .trailing], 10)
//                    }.onReceive(vm.$direction) { action in
//                        guard !filterTabs.isEmpty else { return }
//                        withAnimation {
//                            switch action {
//                            case .left:
//                                proxy.scrollTo(filterTabs.first!, anchor: .leading)
//                            case .right:
//                                proxy.scrollTo(filterTabs.last!, anchor: .trailing)
//                            default:
//                                return
//                            }
//                        }
//                    }.frame(height: 60)
//                    .padding(.top, 5).padding(.bottom, 5)
//                }
//            }
//
//        }
//    }
//}
//
//struct ScrollViewFiltersMap: View {
//    @State var filterTabs = ["FULL MAP", "COMMUNAL"]
//    @Binding var selectedFilter : String
//
//    @StateObject var vm = ScrollToModel()
//
//    var body: some View {
//        HStack {
//
//            ScrollView(.horizontal, showsIndicators: false) {
//
//                ScrollViewReader { (proxy: ScrollViewProxy) in
//                    LazyHStack {
//                        HStack(spacing: 10) {
//                            ForEach(filterTabs, id: \.self) { i in
//
//                                Button(action: {
//                                    self.selectedFilter = i
//                                }) {
//                                    Text(i)
//                                        .font(.system(size: 13, weight: .semibold, design: .rounded))
//                                        .foregroundColor(self.selectedFilter == i ? .white : .gray)
//                                }.buttonStyle(PlainButtonStyle())
//                                .frame(width: 150, height: 40)
//                                .background(self.selectedFilter == i ? Color("customCyan") : .white)
//                                .cornerRadius(12)
//                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).foregroundColor(self.selectedFilter == i ? .clear : .gray))
//                            }
//                        }.padding([.leading, .trailing], 10)
//                    }.onReceive(vm.$direction) { action in
//                        guard !filterTabs.isEmpty else { return }
//                        withAnimation {
//                            switch action {
//                            case .left:
//                                proxy.scrollTo(filterTabs.first!, anchor: .leading)
//                            case .right:
//                                proxy.scrollTo(filterTabs.last!, anchor: .trailing)
//                            default:
//                                return
//                            }
//                        }
//                    }.frame(height: 60)
//                    .padding(.top, 5).padding(.bottom, 5)
//                }
//            }
//        }
//    }
//}



class ScrollToModel2: ObservableObject {
    enum Action {
        case left
        case right
    }
    @Published var direction: Action? = nil
}

