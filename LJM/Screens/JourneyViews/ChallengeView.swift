//
//  ChallengeView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct ChallengeView: View {
    
    var challengeTabs : [String] {
        return LJM.storage.challenges.map({ $0.name.replacingOccurrences(of: "challenge ", with: "") })
    }
    
    @State var selectedFilter = ""
    @State var selectedFilterInsideButton = "All"
    @State private var searchText = ""
    @State var selectedStrands = [String]()
    
    @Environment(\.colorScheme) var colorScheme
    
//    @EnvironmentObject var challengeStore: ChallengesStore
//    @EnvironmentObject var strandsStore: StrandsStore
    
    @ObservedObject var totalLOs : TotalNumberLearningObjectives
    @ObservedObject var selectedSegmentView : SelectedSegmentView
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10, content: {
                TitleScreenView(title: "Challenge")
                
                DescriptionTitleScreenView(desc: "Here you will find the Learning Objectives involved in each Challenge you will face during the Academy year.")
            }).frame(maxWidth: .infinity)
            
            ScrollViewFilters(filterTabs: challengeTabs, selectedFilter: $selectedFilter, vm: ScrollToModel())
            
            ZStack(alignment: .topLeading) {
                NumberTotalLearningOjbectivesView(totalLOs: self.totalLOs.total)
                
                SearchBarExpandableJourney(txtSearchBar: $searchText).background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                    .padding(.trailing, 200)
                    .frame(maxWidth: .infinity,  alignment: .trailing)
                
                DropDownMenuFilters(selectedStrands: $selectedStrands, filterOptions: setupStrandsOnFilter(strands: LJM.storage.strands))
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .zIndex(1)
                
                ZStack(alignment: .top) {
                    
                    Text("No learning objectives found ...")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.customDarkGrey)
                        .padding(.top, 75)
                        .isHidden(totalLOs.total > 0 ? true : false)
                    
                    ScrollViewLearningObjectives(totalLOs: totalLOs, learningPathSelected: Binding.constant(nil), filterChallenge: selectedFilter, isAddable: true, textFromSearchBar: searchText, selectedStrands: selectedStrands).padding(.top, 50)
                }
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
    
    func setupStrandsOnFilter(strands: [Strand]) -> [FilterChoice] {
        
        var arrayStrandsFilter = [FilterChoice]()
        
        for strand in strands {
            arrayStrandsFilter.append(FilterChoice(descriptor: strand.name))
        }
        
        return arrayStrandsFilter
    }
}

//struct ChallengeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeView()
//    }
//}
