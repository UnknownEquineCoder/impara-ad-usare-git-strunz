//
//  OtherChallenges.swift
//  LJM
//
//  Created by denys pashkov on 14/02/22.
//

import SwiftUI

struct OtherChallenges: View {
    
    let backgroundColor : Color = .green
    let backgroundImage : String = "calendar"
    
    var body: some View {
        HStack(alignment:.top){
            VStack(alignment:.leading,spacing: 0){
                Text("MC4")
                    .foregroundColor(Color.white)
                    .font(.system(size: 13, weight: .heavy))
                    .padding(.bottom, 20)
                    
                Text("Hurricane Challenge")
                    .foregroundColor(Color.white)
                    .font(.system(size: 26, weight: .bold))
                    .padding(.bottom, 6)
                Text("XX/YY - XX/YY")
                    .foregroundColor(Color.descriptionTextColor)
                    .font(.system(size: 11, weight: .semibold))
                    .padding(.bottom, 10)
                Text("Lorem ipsum dolor sit amet, consectetur adipisci elit, sed do eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullamco laboriosam, nisi ut aliquid ex ea commodi consequatur.")
                    .foregroundColor(Color.descriptionTextColor)
                    .font(.system(size: 13, weight: .regular))
            }
            .padding(.top, 19)
            .padding(.bottom, 50)
            .frame(width: 400)
            .padding(.leading, 32)
            
            Spacer()
        }
        .background(ZStack{
//            Color.white.opacity(0.2)
            LinearGradient(colors: [backgroundColor, .clear], startPoint: .leading, endPoint: .trailing)
//            HStack{
//                Spacer()
//                Image(systemName: backgroundImage).resizable()
//            }
            
        })
        .cornerRadius(9)
    }
}

struct OtherChallenges_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 20){
            OtherChallenges()
            OtherChallenges()
        }
        .padding(.horizontal, 50)
        
    }
}
