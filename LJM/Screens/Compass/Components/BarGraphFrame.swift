//
//  BarGraphFrame.swift
//  LJM
//
//  Created by Laura Benetti on 04/03/21.
//

import SwiftUI

struct BarGraphFrame: View {
    var color: Color
    var title: String
    var skills: [String]
    var levels: [String] = ["No Exposure", "Beginning", "Progressing", "Proficient", "Exemplary"]
    
    @Binding var targetLabel: String
    @Binding var showView: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Rectangle().fill(Color.clear)
                    .border(color)
                    .frame(width: 1400.toScreenSize(), height: 75 * CGFloat(skills.count))
                VStack{
                    HStack{
                        Text(title)
                            .foregroundColor(color)
                            .font(.system(size: 29.toFontSize()))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading, 49.toScreenSize())
                    HStack {
                        Spacer()
                        HStack(spacing: (geo.size.width*0.66) / 10){
                            
                            ForEach(levels, id: \.self){
                                level in
                                Text(level)
                                    .font(.system(size: 16.toFontSize()))
                                    .fontWeight(.light)
                                
                            }
                            
                            
                        }
                        .frame(width: geo.size.width * 0.66)
                        .padding(.leading, geo.size.width/20)
                        .padding(.trailing, 130.toScreenSize())
                        
                        
                        
                    }
                    HStack {
                        VStack(alignment: .leading, spacing: 49.toScreenSize()) {
                        ForEach(skills, id: \.self) { skill in
                            Text(skill)
                                .foregroundColor(color)
                                .font(.system(size: 20.toFontSize()))
                                .fontWeight(.light)
                                .underline()
                                .onTapGesture {
                                    self.targetLabel = skill
                                    self.showView = true
                                }
                            
                        }
                            
                        }.padding(.leading, 51.toScreenSize())
                        
                        
                        
                        Spacer()
                        VStack(spacing: 51.toScreenSize()){
                            ForEach(skills, id: \.self){
                                skill in
                                
                                ProgressBarGraph(progress: Double(Int.random(in: 20...100)), color: color)
                                    .frame(width: geo.size.width * 0.66, height: 16.toScreenSize())
                                    .padding(.trailing, 116.toScreenSize())
                                
                            }
                        }
                        
                        
                    }
                    /*
                     ProgressBarGraph(progress: 45, color: color)
                     .frame(width: geo.size.width * 0.8, height: 16.toScreenSize())             **/
                }
                .padding(.top, 30)
                .padding(.bottom, 30)
            }
        }.frame(width: 1400.toScreenSize(), height: 75 * CGFloat(skills.count))
    }
}

struct BarGraphFrame_Previews: PreviewProvider {
    static var previews: some View {
        //BarGraphFrame(color: .red, title: "PROCESS", skills: ["Aldo","Giovanni","Giacomo"])
        EmptyView()
    }
}
