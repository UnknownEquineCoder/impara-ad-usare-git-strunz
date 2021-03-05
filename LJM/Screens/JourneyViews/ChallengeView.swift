//
//  ChallengeView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct ChallengeView: View {
    
    var challengeTabs = ["MC3", "E5", "WF3"]
    @State var selectedFilter = "MC3"
    @State var selectedFilterInsideButton = "All"
    @State private var searchText = ""
    @State var selectedStrands = [String]()
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    @ObservedObject var totalLOs = TotalNumberLearningObjectives()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10, content: {
                TitleScreenView(title: "Challenge")
                    .onTapGesture {
                        print("IOJUHYGTFGUH \(learningPathsStore.learningPaths)")
                    }
                    
                DescriptionTitleScreenView(desc: "Here you will find the Learning Objectives involved in each Challenge you will face during the Academy year.")
            }).frame(maxWidth: .infinity)
            
            ScrollViewFilters(filterTabs: challengeTabs, selectedFilter: $selectedFilter, vm: ScrollToModel())
            
            ZStack(alignment: .topLeading) {
                NumberTotalLearningOjbectivesView(totalLOs: self.totalLOs.total)
                
                SearchBarExpandableJourney(txtSearchBar: $searchText).background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                    .padding(.trailing, 200)
                    .frame(maxWidth: .infinity,  alignment: .trailing)
                
                DropDownMenuFilters(selectedStrands: $selectedStrands)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .zIndex(1)
                
                ScrollViewLearningObjectives(totalLOs: totalLOs, filterChallenge: selectedFilter, isAddable: true, textFromSearchBar: searchText, selectedStrands: selectedStrands).padding(.top, 50)
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
