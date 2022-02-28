////
////  ChallengeMainView.swift
////  LJM
////
////  Created by denys pashkov on 16/02/22.
////
//
//import SwiftUI
//
//struct ChallengeMainView: View {
//    
//    @State private var offset = CGFloat.zero
//    @State private var toggleFilters: Bool = false
//    @State private var selectedFilters: Dictionary<String, Array<String>> = [:]
//    @State private var scrollTarget: Bool = false
//    @State private var isViewSelected = false
//    
//    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
//    
//    let tempChallenge = Challenge(name: "Marco Polo Challenge",
//                                  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis mattis risus, eget tristique felis. Donec sit amet tortor suscipit mi consectetur hendrerit vitae eu elit. Phasellus vitae risus feugiat, tincidunt leo id, aliquet orci. Proin condimentum fringilla accumsan. Sed posuere arcu sed orci imperdiet mattis. Sed varius molestie sodales. Donec lobortis nisi lacus, eget mollis quam aliquam in. In varius leo mattis orci eleifend, nec elementum sem luctus.",
//                                    ID: "NS1",
//                                    start_Date: "11/12",
//                                    end_Date: "12/12",
//                                    LO_IDs: ["BUS06","BUS07","BUS08","BUS09","BUS10","BUS11","BUS12","BUS13","BUS14","BUS015","BUS16","BUS17","BUS18","BUS19","BUS20","BUS21","BUS22","BUS23","BUS24","BUS25","BUS26","BUS27","BUS28","BUS29","BUS30","BUS31","BUS32","BUS33"])
//    
//    var body: some View {
//        ZStack{
//            
//            
//            
//            if isViewSelected {
//                
//                SpecificChallengeView(challenge: tempChallenge, isViewSelected: $isViewSelected, filtered_Learning_Objectives: learningObjectiveStore.learningObjectives.filter({
//                    tempChallenge.LO_IDs.contains($0.ID)
//                }))
//                
//            } else {
//                ChallengeView(offset: $offset, isViewSelected: $isViewSelected)
//                
//                if(offset > 400) {
//                    Topbar(title: "Challenge", filters: selectedFilters, fromCompass: true, scrollTarget: $scrollTarget, toggleFilters: $toggleFilters)
//                }
//            }
//                
//        }
//    }
//}
//
//struct ChallengeMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeMainView()
//    }
//}
