//
//  ChallengeView.swift
//  LJM
//
//  Created by denys pashkov on 14/02/22.
//

import SwiftUI

struct ChallengeView: View {
    
    @Binding var offset : CGFloat
    @Binding var isViewSelected : Bool
    @Binding var selectedChallenge : Challenge?
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    let columns = [
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15){
                if let lastChallenge = learningObjectiveStore.getChallenges().last {
                    MainChallenge(challenge: lastChallenge)
                        .padding(.bottom, 5)
                        .onTapGesture {
                            isViewSelected = true
                            selectedChallenge = lastChallenge
                        }
                }
                
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Range(0...learningObjectiveStore.getChallenges().count - 2), id: \.self) { index in
                        OtherChallenges(challenge: learningObjectiveStore.getChallenges()[index])
                            .onTapGesture {
                                isViewSelected = true
                                selectedChallenge = learningObjectiveStore.getChallenges()[index]
                            }
                    }
                }
        
            }
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
        }
        .padding(.horizontal, 50)
        //        .padding(.top, -5)
        
    }
}

//struct ChallengeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeView(offset: .constant(0.1), isViewSelected: .constant(false))
//    }
//}
