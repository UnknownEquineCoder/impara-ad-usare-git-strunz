//
//  ChallengeMainView.swift
//  LJM
//
//  Created by denys pashkov on 16/02/22.
//

import SwiftUI

struct ChallengeMainView: View {
    
    @State private var offset = CGFloat.zero
    @State private var toggleFilters: Bool = false
    @State private var selectedFilters: Dictionary<String, Array<String>> = [:]
    @State private var scrollTarget: Bool = false
    @State private var isViewSelected = false
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    @State var selectedChallenge : Challenge? = nil
    
    var body: some View {
        ZStack{
            
            
            
            if isViewSelected {
                SpecificChallengeView(challenge: $selectedChallenge, isViewSelected: $isViewSelected, challenges: learningObjectiveStore.challenges, filtered_Learning_Objectives: learningObjectiveStore.learningObjectives.filter({
                    if let challenge = selectedChallenge {
                        return $0.challengeID.contains(challenge.ID)
                    }
                    return false
                }))
                    
                
            } else {
                ChallengeView(offset: $offset, isViewSelected: $isViewSelected, selectedChallenge: $selectedChallenge)
                if(offset > 400) {
                    Topbar(title: "Challenge", filters: selectedFilters, fromCompass: true, scrollTarget: $scrollTarget, toggleFilters: $toggleFilters)
                }
            }
                
        }
        .onChange(of: isViewSelected) { newValue in
            if newValue {
                
            }
        }
    }
}

//struct ChallengeMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeMainView()
//    }
//}
