//
//  MainChallenge.swift
//  LJM
//
//  Created by denys pashkov on 14/02/22.
//

import SwiftUI

struct MainChallenge: View {
    
    let backgroundColor : Color = .red
    
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
            }
            .frame(width: 288)
            .padding(.top, 86)
            .padding(.bottom, 81 + 56)
            .padding(.leading, 27)
            
            Spacer()
        }
        .background(
            GeometryReader { geometry in
                ZStack{
                    backgroundColor
                    HStack{
                        Color.init(red: 60/255, green: 60/255, blue: 67/255).opacity(0.4).blur(radius: 0).frame(width: geometry.size.width/3,alignment:.leading)
                        Spacer()
                    }
                    
                }
            })
    }
}

struct MainChallenge_Previews: PreviewProvider {
    static var previews: some View {
        MainChallenge()
    }
}
