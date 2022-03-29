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
        ZStack{
            Color.bgColor
                .padding(.top, -40)
                .padding(.leading, -10)
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15){
                if let lastChallenge = learningObjectiveStore.getChallenges().last {
                    MainChallenge(challenge: lastChallenge, isViewSelected: $isViewSelected, selectedChallenge: $selectedChallenge)
                        .padding(.bottom, 5)
                }
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Range(0...learningObjectiveStore.getChallenges().count - 2), id: \.self) { index in
                        OtherChallenges(challenge: learningObjectiveStore.getChallenges()[index], isViewSelected: $isViewSelected, selectedChallenge: $selectedChallenge)
                    }
                }
        
            }
            .padding(.bottom, 30)
            .id(0)
            .background(
                GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey2.self,
                                           value: -$0.frame(in: .named("scroll")).origin.y)
                }
            )
            .onPreferenceChange(ViewOffsetKey2.self) { element in
                withAnimation(.linear(duration: 0.1), {
                    self.offset = element
                })
            }
        }
        .padding(.horizontal, 50)
        }
    }
}

//struct ChallengeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeView(offset: .constant(0.1), isViewSelected: .constant(false))
//    }
//}
