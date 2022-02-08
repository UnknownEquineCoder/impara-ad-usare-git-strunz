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
    let levels: [String] = ["Not Evaluated", "Beginning", "Progressing", "Proficient", "Exemplary"]
    
    @Binding var progress : [Double]
    @Binding var expectation_Progress : [Double]
    
    @Binding var targetLabel: String?
    @Binding var animation_Trigger : Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                //                RoundedRectangle(cornerRadius: 18)
                //                    .stroke(color, lineWidth: 2)
                //                    .frame(height: 75 * CGFloat(skills.count))
                //                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Rectangle()
                    .fill(color).opacity(0.1)
                //                    .border(color)
                    .frame(height: 75 * CGFloat(skills.count))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .addBorder(color, width: 1.5, cornerRadius: 10)
                
                
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
                    HStack (alignment: .center){
                        
                        VStack(alignment: .center, spacing: 49.toScreenSize()){
                            ForEach(0..<skills.count){ index in
                                HStack(alignment: .center){
                                    Text(skills[index])
                                        .foregroundColor(color)
                                        .font(.system(size: 20.toFontSize()))
                                        .fontWeight(.light)
                                        .underline()
                                        .cursor(.pointingHand)
                                        .onTapGesture {
                                            self.targetLabel = skills[index]
                                        }.padding(.leading, 51.toScreenSize())
                                    
                                    Spacer()
                                    
                                    ZStack{
                                        
                                        ProgressBarGraph(progress: (animation_Trigger ? expectation_Progress[index] * 20 : 0 ) + 1, color: color.opacity(0.4))
                                            .frame(width: geo.size.width * 0.66, height: 16.toScreenSize())
                                            .padding(.trailing, 116.toScreenSize())
                                        
                                        ProgressBarGraph(progress: (animation_Trigger ? progress[index] * 20 : 0 ) + 1, color: color)
                                            .frame(width: geo.size.width * 0.66, height: 16.toScreenSize())
                                            .padding(.trailing, 116.toScreenSize())
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, 30)
            }
        }.frame(height: 75 * CGFloat(skills.count))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct BarGraphFrame_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
