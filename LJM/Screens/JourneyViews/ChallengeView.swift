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
                Text("Challenge")
                    .font(.system(size: 40, weight: .medium))
                    .fontWeight(.medium)
                    .foregroundColor(Color.customBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                Text("Here you will find the Learning Objectives involved in each Challenge you will face during the Academy year.")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color.customDarkGrey)
                    .padding(.top, 20)
                    .padding(.trailing, 90)
                
                Rectangle().frame(height: 1).foregroundColor(Color.customDarkGrey)
            }).frame(maxWidth: .infinity)
            
            ScrollViewFilters(filterTabs: challengeTabs, selectedFilter: $selectedFilter, vm: ScrollToModel())
            
            ZStack(alignment: .topLeading) {
                Text("Learning Objectives")
                    .foregroundColor(Color.customDarkGrey)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                DropDownMenuFilters()
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .zIndex(1)
                
                ScrollViewLearningObjectives(filterChallenge: selectedFilter, isAddable: true).padding(.top, 50)
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
