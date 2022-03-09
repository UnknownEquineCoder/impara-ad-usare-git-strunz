//
//  OtherChallenges.swift
//  LJM
//
//  Created by denys pashkov on 14/02/22.
//

import SwiftUI

struct OtherChallenges: View {
    
    let backgroundColor : Color = .green
    let challenge : Challenge
    
    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
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
                Text("\(getDate(challenge:challenge)!, formatter: OtherChallenges.formatter) - \(getEndDate(challenge:challenge)!,formatter: OtherChallenges.formatter)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .font(.subheadline)
                    .padding(.bottom, 10)
            }
            .padding(.top, 19)
            .padding(.bottom, 50)
//            .frame(width: 400)
            .padding(.leading, 27)
            
            Spacer()
        }
        .background(
            GeometryReader { geometry in
                ZStack(alignment: .leading){
                    Image(challenge.ID)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .clipped()
                        .offset(y: -50)
                   
                    Image(challenge.ID)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width/2.5, alignment:.leading)
                        .clipped()
                        .offset(y: -50)
                        .blur(radius: 5, opaque: false)

                    Color.init(red: 60/255, green: 60/255, blue: 67/255)
                        .opacity(0.3)
                        .frame(width: geometry.size.width/2.5,alignment:.leading)
                    
                }
            }
        )
        .cornerRadius(9)
    }
}

struct OtherChallenges_Previews: PreviewProvider {
    
    static var previews: some View {
        let tempChallenge = Challenge(name: "ASD",
                                      ID: "NS1",
                                      start_Date: "11/12",
                                      end_Date: "12/12")
        HStack(spacing: 20){
            OtherChallenges(challenge: tempChallenge)
            OtherChallenges(challenge: tempChallenge)
        }
        .padding(.horizontal, 50)
        
    }
}
