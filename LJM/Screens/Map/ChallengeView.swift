////
////  ChallengeView.swift
////  LJM
////
////  Created by Tony Tresgots on 25/11/2020.
////
//
//import SwiftUI
//
//struct ChallengeView: View {
//    
//    var challengeTabs : [String] {
//        return ["MC1", "MC2", "TEST3"]
//    }
//    
//    @State var selectedFilter = ""
//    @State var selectedFilterInsideButton = "All"
//    @State private var searchText = ""
//    @State var selectedStrands = [String]()
//    
//    let shared : singleton_Shared = singleton_Shared()
//    
//    @Environment(\.colorScheme) var colorScheme
//    
//    @ObservedObject var selectedSegmentView : SelectedSegmentView
//    
//    var body: some View {
//        VStack {
//            VStack(alignment: .leading, spacing: 10, content: {
//                TitleScreenView(title: "Challenge")
//                
//                DescriptionTitleScreenView(desc: "Here you will find the Learning Objectives involved in each Challenge you will face during the Academy year.")
//            }).frame(maxWidth: .infinity)
//            
//            ScrollViewFilters(filterTabs: challengeTabs, selectedFilter: $selectedFilter, vm: ScrollToModel())
//            
//            ZStack(alignment: .topLeading) {
//                NumberTotalLearningOjbectivesView(totalLOs: 10)
//                
//                SearchBarExpandableJourney(txtSearchBar: $searchText, isUpdated: .constant(true)).background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
//                    .padding(.trailing, 200)
//                    .frame(maxWidth: .infinity,  alignment: .trailing)
//                
//                DropDownMenuFilters(selectedStrands: $selectedStrands, filterOptions: setupStrandsOnFilter())
//                    .buttonStyle(PlainButtonStyle())
//                    .padding(.trailing, 20)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                    .zIndex(1)
//                
//                ZStack(alignment: .top) {
//                    
//                    Text("No learning objectives found ...")
//                        .font(.system(size: 25, weight: .semibold, design: .rounded))
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(Color.customDarkGrey)
//                        .padding(.top, 75)
//                      //  .isHidden(totalLOs.total > 0 ? true : false)
//                    
//                    ScrollViewLearningObjectives(learningPathSelected: Binding.constant(nil), filterChallenge: selectedFilter, isAddable: true, textFromSearchBar: $searchText, selectedStrands: selectedStrands).padding(.top, 50).padding(.bottom, 50)
//                }
//            }.frame(maxWidth: .infinity).padding(.top, 10)
//        }.padding(.leading, 50).padding(.trailing, 50)
//    }
//    
//    func setupStrandsOnFilter() -> [FilterChoice] {
//        
//        var arrayStrandsFilter = [FilterChoice]()
//        
//        for learningObjective in self.shared.learning_Objectives {
//            arrayStrandsFilter.append(FilterChoice(descriptor: learningObjective.strand))
//        }
//                
//        return arrayStrandsFilter
//    }
//}
