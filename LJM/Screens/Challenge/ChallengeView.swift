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
    
    let tempChallenge = Challenge(name: "Marco Polo Challenge", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis mattis risus, eget tristique felis. Donec sit amet tortor suscipit mi consectetur hendrerit vitae eu elit. Phasellus vitae risus feugiat, tincidunt leo id, aliquet orci. Proin condimentum fringilla accumsan. Sed posuere arcu sed orci imperdiet mattis. Sed varius molestie sodales. Donec lobortis nisi lacus, eget mollis quam aliquam in. In varius leo mattis orci eleifend, nec elementum sem luctus.", ID: "NS1",
                                                              start_Date: "11/12",
                                                              end_Date: "12/12",
                                                              LO_IDs: ["BUS06","BUS07","BUS08","BUS09","BUS10","BUS11","BUS12","BUS13","BUS14","BUS015","BUS16","BUS17","BUS18","BUS19","BUS20","BUS21","BUS22","BUS23","BUS24","BUS25","BUS26","BUS27","BUS28","BUS29","BUS30","BUS31","BUS32","BUS33"])
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15){
                MainChallenge(challenge: tempChallenge)
                    .padding(.bottom, 5)
                    .onTapGesture {
                        isViewSelected = true
                    }
                
                HStack(spacing: 20){
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
                        }
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
                        }
                }
                
                HStack(spacing: 20){
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
                        }
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
                        }
                }
                
                HStack(spacing: 20){
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
                        }
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
                        }
                }
                
                HStack(spacing: 20){
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
                        }
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
                        }
                }
                
                HStack(spacing: 20){
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
                        }
                    OtherChallenges(challenge: tempChallenge)
                        .onTapGesture {
                            isViewSelected = true
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

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(offset: .constant(0.1), isViewSelected: .constant(false))
    }
}
