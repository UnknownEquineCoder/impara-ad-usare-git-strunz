//
//  MainChallenge.swift
//  LJM
//
//  Created by denys pashkov on 14/02/22.
//

import SwiftUI

struct MainChallenge: View {
    
    let backgroundColor : Color = .red
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
            .frame(width: 288)
            .padding(.top, 86)
            .padding(.bottom, 81 + 56)
            .padding(.leading, 27)
            
            Spacer()
        }
        .background(ZStack{
            LinearGradient(colors: [backgroundColor, .clear], startPoint: .leading, endPoint: .trailing)
//            HStack{
//                Spacer()
//                Image(systemName: backgroundImage).resizable()
//            }
            
        })
    }
}

struct MainChallenge_Previews: PreviewProvider {
    static var previews: some View {
        MainChallenge()
    }
}
