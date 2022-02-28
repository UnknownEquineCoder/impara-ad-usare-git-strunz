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
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15){
                MainChallenge(challenge: learningObjectiveStore.challenges[0])
                    .padding(.bottom, 5)
                    .onTapGesture {
                        isViewSelected = true
                        selectedChallenge = learningObjectiveStore.challenges[0]
                    }
                
                HStack(spacing: 20){
                    OtherChallenges(challenge: learningObjectiveStore.challenges[1])
                        .onTapGesture {
                            isViewSelected = true
                            selectedChallenge = learningObjectiveStore.challenges[1]
                        }
                    OtherChallenges(challenge: learningObjectiveStore.challenges[2])
                        .onTapGesture {
                            isViewSelected = true
                            selectedChallenge = learningObjectiveStore.challenges[2]
                        }
                }
                
                Spacer()
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
