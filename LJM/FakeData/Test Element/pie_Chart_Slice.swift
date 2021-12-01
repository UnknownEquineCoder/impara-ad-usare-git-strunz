//
//  PieSliceView.swift
//
//
//  Created by Nazar Ilamanov on 4/23/21.
//

import SwiftUI

@available(OSX 10.15, *)
struct PieSlice: View {
    var pieSliceData: PieSliceData
    let scaling : CGFloat
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    path.move(
                        to: CGPoint(
                            x: width * scaling,
                            y: height * scaling
                        )
                    )
                    
                    path.addArc(center: CGPoint(x: width * scaling, y: height * scaling), radius: width * scaling, startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle, endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle, clockwise: false)
                    
                }
                .fill(pieSliceData.color)
                
                Text(pieSliceData.text)
                    .position(
                        x: geometry.size.width * scaling * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
                        y: geometry.size.height * scaling * CGFloat(1.0 - 0.78 * sin(self.midRadians))
                    )
                    .foregroundColor(Color.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

@available(OSX 10.15, *)
struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

@available(OSX 10.15.0, *)
struct PieSlice_Previews: PreviewProvider {
    static var previews: some View {
        PieSlice(pieSliceData: PieSliceData(startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 120.0), text: "30%", color: Color.black), scaling: 0.3)
    }
}
