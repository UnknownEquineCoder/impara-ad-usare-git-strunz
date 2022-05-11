//
//  MainChallenge.swift
//  LJM
//
//  Created by denys pashkov on 14/02/22.
//

import SwiftUI

struct MainChallenge: View {
    
    let challenge : Challenge
    @Binding var isViewSelected : Bool
    @Binding var selectedChallenge : Challenge?
    
    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    var body: some View {
        ZStack{
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
                    
                    Text("\(getDate(challenge:challenge)!, formatter: MainChallenge.formatter) - \(getEndDate(challenge:challenge)!,formatter: MainChallenge.formatter)")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .padding(.bottom, 10)
                }
                .padding(.top, 86)
                .padding(.bottom, 81 + 56)
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
                            .offset(y: -80)
                        
                        Image(challenge.ID)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width/3, alignment:.leading)
                            .clipped()
                            .blur(radius: 5, opaque: false)
                            .offset(y: -80)
                        
                        Color.init(red: 60/255, green: 60/255, blue: 67/255)
                            .opacity(0.3)
                            .frame(width: geometry.size.width/3,alignment:.leading)
                        
                    }
                })
            Color.white.opacity(0.0001)
                .onTapGesture {
                    isViewSelected = true
                    selectedChallenge = challenge
                }
        }
        .cornerRadius(9)
    }
}
