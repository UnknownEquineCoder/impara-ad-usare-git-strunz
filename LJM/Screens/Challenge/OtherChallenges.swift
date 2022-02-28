////
////  OtherChallenges.swift
////  LJM
////
////  Created by denys pashkov on 14/02/22.
////
//
//import SwiftUI
//
//struct OtherChallenges: View {
//    
//    let backgroundColor : Color = .green
//    let challenge : Challenge
//    
//    var body: some View {
//        HStack(alignment:.top){
//            VStack(alignment:.leading,spacing: 0){
//                
//                Text(challenge.ID)
//                    .fontWeight(.heavy)
//                    .foregroundColor(Color.white)
//                    .font(.headline)
//                    .padding(.bottom, 20)
//                Text(challenge.name)
//                    .fontWeight(.bold)
//                    .foregroundColor(Color.white)
//                    .font(.largeTitle)
//                    .padding(.bottom, 6)
//                Text("\(challenge.start_Date) - \(challenge.end_Date)")
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color.descriptionTextColor)
//                    .font(.subheadline)
//                    .padding(.bottom, 10)
//                Text(challenge.description)
//                    .foregroundColor(Color.descriptionTextColor)
//                    .font(.body)
//                    .frame(width: 200)
//            }
//            .padding(.top, 19)
//            .padding(.bottom, 50)
////            .frame(width: 400)
//            .padding(.leading, 32)
//            
//            Spacer()
//        }
//        .background(
//            GeometryReader { geometry in
//                ZStack{
//                    Image("Placeholder-Daiquiri")
//                                        .resizable()
//                                        .scaledToFill()
//                                        .edgesIgnoringSafeArea(.all)
//                                        .clipped()
////                    backgroundColor
//                    HStack{
//                        Color.init(red: 60/255, green: 60/255, blue: 67/255).opacity(0.6).blur(radius: 0).frame(width: (geometry.size.width)/2,alignment:.leading)
//                        Spacer()
//                    }
//                    
//                }
//            }
//        )
//        .cornerRadius(9)
//    }
//}
//
//struct OtherChallenges_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        let tempChallenge = Challenge(name: "ASD", description: "wevnskduvbwkdeh", ID: "NS1",
//                                                                  start_Date: "11/12",
//                                                                  end_Date: "12/12",
//                                                                  LO_IDs: ["BUS06","BUS07","BUS08","BUS09","BUS10","BUS11","BUS12","BUS13","BUS14","BUS015","BUS16","BUS17","BUS18","BUS19","BUS20","BUS21","BUS22","BUS23","BUS24","BUS25","BUS26","BUS27","BUS28","BUS29","BUS30","BUS31","BUS32","BUS33"])
//        HStack(spacing: 20){
//            OtherChallenges(challenge: tempChallenge)
//            OtherChallenges(challenge: tempChallenge)
//        }
//        .padding(.horizontal, 50)
//        
//    }
//}
