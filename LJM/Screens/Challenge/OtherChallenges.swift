//
//  OtherChallenges.swift
//  LJM
//
//  Created by denys pashkov on 14/02/22.
//

import SwiftUI

struct OtherChallenges: View {
    
    let backgroundColor : Color = .green
    let challenge : Challenge = Challenge.init(name: "Peppe", description: "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed do eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullamco laboriosam, nisi ut aliquid ex ea commodi consequatur.", ID: "MC22", start_Date: "22/05", end_Date: "22/06", LO_IDs: [])
    
    var body: some View {
        HStack(alignment:.top){
            VStack(alignment:.leading,spacing: 0){
                Text(challenge.ID)
                    .foregroundColor(Color.white)
                    .font(.system(size: 13, weight: .heavy))
                    .padding(.bottom, 20)
                    
                Text(challenge.name)
                    .foregroundColor(Color.white)
                    .font(.system(size: 26, weight: .bold))
                    .padding(.bottom, 6)
                Text("\(challenge.start_Date) - \(challenge.end_Date)")
                    .foregroundColor(Color.descriptionTextColor)
                    .font(.system(size: 11, weight: .semibold))
                    .padding(.bottom, 10)
                Text(challenge.description)
                    .foregroundColor(Color.descriptionTextColor)
                    .font(.system(size: 13, weight: .regular))
                    .frame(width: 200)
            }
            .padding(.top, 19)
            .padding(.bottom, 50)
//            .frame(width: 400)
            .padding(.leading, 32)
            
            Spacer()
        }
        .background(
            GeometryReader { geometry in
                ZStack{
                    backgroundColor
                    HStack{
                        Color.init(red: 60/255, green: 60/255, blue: 67/255).opacity(0.4).blur(radius: 0).frame(width: (geometry.size.width)/2,alignment:.leading)
                        Spacer()
                    }
                    
                }
            }
        )
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
