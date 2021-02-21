//
//  MyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct MyJourneyView: View, LJMView {
    @State var selectedPath = "Select your path"
    @State var selectedFilter = "All"
    @State var selectedFilterInsideButton = "All"
    let arrayFilters = ["All", "Core", "Elective", "Evaluated"]
    
    @State private var searchText = ""
    
    @State private var showView = true
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                
                TitleScreenView(title: "My Journey")
                    .onTapGesture {
                        print("JNHBUGY \(learningPathsStore.learningPaths)")
                    }
                
                DropDownMenuSelectPath()
                    .padding(.leading, 250)
                    .padding(.top, 23)
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "Here you will find your Learning Objectives you choose to work on, that will help you build your own path. Based on the path you choose, the arrows will indicate the recommanded level to reach.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                
                ScrollViewFiltersJourney(filterTabs: arrayFilters, selectedFilter: $selectedFilter)
                    .padding(.top, 20)
                    .padding(.top, 120)
                
            }.frame(maxWidth: .infinity)
            
            ZStack(alignment: .topLeading) {
                
               // NumberTotalLearningOjbectivesView(totalLOs: calculateAllLearningObjectives(learningPath: learningPaths))
                NumberTotalLearningOjbectivesView(totalLOs: 10)
                
                TestButtons().padding(.leading, 200).environmentObject(LearningPathStore())
                
                SearchBarExpandableJourney(txtSearchBar: $searchText).background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                    .padding(.trailing, 200)
                    .frame(maxWidth: .infinity,  alignment: .trailing)
                
                DropDownMenuFilters()
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .zIndex(1)
                
                ListViewLearningObjectiveMyJourney(showView: self.$showView, selectedFilter: $selectedFilter, txtSearchBar: $searchText)
                    .padding(.top, 50)
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
    
    func calculateAllLearningObjectives(learningPath: [LearningPath]) -> Int {
        return 10
    }
}

struct TestButtons: View {
   // @Binding var learningPaths : [LearningPath]
    
    @EnvironmentObject private var learningPathStore: LearningPathStore

    var body: some View {
        HStack {
            Button(action: {

            }) {
                Text("Get")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                Webservices.getAllLearningObjectives { (learningObjectives, err) in
                    print("YUIY \(learningObjectives)")
                }
            }) {
                Text("Get LOs")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())

        }
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
                .opacity(filterTabs.count > 8 ? 1 : 0)
            
            ScrollViewFilters(filterTabs: filterTabs, selectedFilter: $selectedFilter, vm: vm).offset(x: filterTabs.count < 8 ? -35 : 0)
            
            ArrowButtonScrollView(vm: vm, direction: .right)
                .buttonStyle(PlainButtonStyle())
                .opacity(filterTabs.count > 8 ? 1 : 0)
        }
    }
}

struct ListViewLearningObjectiveMyJourney: View {
    
    @Binding var showView: Bool
    @Binding var selectedFilter: CoreEnum.RawValue
    @Binding var txtSearchBar : String
    
    var body: some View {
        
        if showView {
            ScrollViewLearningObjectives(filterCore: selectedFilter, isAddable: false, textFromSearchBar: txtSearchBar)
        } else {
            EmptyLearningObjectiveViewJourney()
        }
    }
}

class ScrollToModel: ObservableObject {
    enum Action {
        case left
        case right
    }
    @Published var direction: Action? = nil
}

struct MyJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        MyJourneyView()
    }
}
