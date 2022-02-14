//
//  ChallengeView.swift
//  LJM
//
//  Created by denys pashkov on 14/02/22.
//

import SwiftUI

struct ChallengeView: View {
    var body: some View {
        VStack(spacing: 10){
            MainChallenge()
                .padding(.bottom, 10)
            
            HStack(spacing: 20){
                OtherChallenges()
                OtherChallenges()
            }
            
            Spacer()
        }
        .padding(.horizontal, 50)
//        .padding(.top, -5)
        
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
