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
                    .foregroundColor(Color.descriptionTextColor)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                Text(challenge.description)
                    .foregroundColor(Color.descriptionTextColor)
                    .font(.body)
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
                    Image("Placeholder-Hurricane")
                                        .resizable()
                                        .scaledToFill()
                                        .edgesIgnoringSafeArea(.all)
                                        .clipped()
//                    backgroundColor
                    HStack{
                        Color.init(red: 60/255, green: 60/255, blue: 67/255).opacity(0.6).blur(radius: 0).frame(width: geometry.size.width/3,alignment:.leading)
                        Spacer()
                    }
                    
                }
            }).cornerRadius(9)
    }
}

struct MainChallenge_Previews: PreviewProvider {
    static var previews: some View {
        let tempChallenge = Challenge(name: "ASD", description: "wevnskduvbwkdeh", ID: "NS1",
                                                                  start_Date: "11/12",
                                                                  end_Date: "12/12",
                                                                  LO_IDs: ["BUS06","BUS07","BUS08","BUS09","BUS10","BUS11","BUS12","BUS13","BUS14","BUS015","BUS16","BUS17","BUS18","BUS19","BUS20","BUS21","BUS22","BUS23","BUS24","BUS25","BUS26","BUS27","BUS28","BUS29","BUS30","BUS31","BUS32","BUS33"])
        MainChallenge(challenge: tempChallenge)
    }
}

//struct VisualEffectView: NSViewRepresentable
//{
//    let material: NSVisualEffectView.Material
//    let blendingMode: NSVisualEffectView.BlendingMode
//
//    func makeNSView(context: Context) -> NSVisualEffectView
//    {
//        let visualEffectView = NSVisualEffectView()
//        visualEffectView.material = material
//        visualEffectView.blendingMode = blendingMode
//        visualEffectView.state = NSVisualEffectView.State.active
//        return visualEffectView
//    }
//
//    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context)
//    {
//        visualEffectView.material = material
//        visualEffectView.blendingMode = blendingMode
//    }
//}


public struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode

    public init(
        material: NSVisualEffectView.Material = .contentBackground,
        blendingMode: NSVisualEffectView.BlendingMode = .withinWindow
    ) {
        self.material = material
        self.blendingMode = blendingMode
    }

    public func makeNSView(context: Context) -> NSVisualEffectView {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = NSVisualEffectView.State.active
        return visualEffectView
    }

    public func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context) {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}
