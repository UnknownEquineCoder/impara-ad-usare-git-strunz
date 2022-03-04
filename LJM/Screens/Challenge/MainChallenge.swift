//
//  MainChallenge.swift
//  LJM
//
//  Created by denys pashkov on 14/02/22.
//

import SwiftUI

struct MainChallenge: View {
    
    let backgroundColor : Color = .red
    
    let challenge : Challenge
    
    var body: some View {
        
        HStack(alignment:.top){
            VStack(alignment:.leading,spacing: 0){
                Text(challenge.ID)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .padding(.bottom, 20)
                    
                Text(challenge.name)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .padding(.bottom, 6)
                Text("\(challenge.start_Date) - \(challenge.end_Date)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .font(.subheadline)
                    .padding(.bottom, 10)
            }
//            .frame(width: 288)
            .padding(.top, 86)
            .padding(.bottom, 81 + 56)
            .padding(.leading, 27)
            
            Spacer()
        }
        .background(
            GeometryReader { geometry in
                ZStack(alignment: .leading){
                    Image("Placeholder-Hurricane")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .clipped()
                        
                    Image("Placeholder-Hurricane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width/3, alignment:.leading)
                        .clipped()
                        .blur(radius: 5, opaque: false)

                    Color.init(red: 60/255, green: 60/255, blue: 67/255)
                        .opacity(0.3)
                        .frame(width: geometry.size.width/3,alignment:.leading)
                }
            }).cornerRadius(9)
    }
}

struct MainChallenge_Previews: PreviewProvider {
    static var previews: some View {
        let tempChallenge = Challenge(name: "ASD",
                                      ID: "NS1",
                                      start_Date: "11/12",
                                      end_Date: "12/12")
        MainChallenge(challenge: tempChallenge)
    }
}


