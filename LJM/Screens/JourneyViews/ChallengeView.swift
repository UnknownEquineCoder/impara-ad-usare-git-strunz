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
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10, content: {
                TitleScreenView(title: "Challenge")
                    
                DescriptionTitleScreenView(desc: "Here you will find the Learning Objectives involved in each Challenge you will face during the Academy year.")
            }).frame(maxWidth: .infinity)
            
            ScrollViewFilters(filterTabs: challengeTabs, selectedFilter: $selectedFilter, vm: ScrollToModel())
            
            ZStack(alignment: .topLeading) {
                NumberTotalLearningOjbectivesView(totalLOs: 40)
                
                DropDownMenuFilters()
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .zIndex(1)
                
                ScrollViewLearningObjectives(filterChallenge: selectedFilter, isAddable: true, textFromSearchBar: "").padding(.top, 50)
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
