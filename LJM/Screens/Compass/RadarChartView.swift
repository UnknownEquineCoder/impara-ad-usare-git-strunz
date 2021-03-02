//
//  RadarChartView.swift
//  LJM
//
//  Created by Laura Benetti on 22/02/21.
//

import Foundation
import SwiftUI
import Shapes

struct RadarChart: View {
    var data: [Double]
    let gridColor: Color
    let dataColor: Color
    @Environment(\.colorScheme) var colorScheme
    
    
    init(data: [Double], gridColor: Color = Color(red: 219/255, green: 219/255, blue: 219/255), dataColor: Color = .blue) {
        self.data = data
        self.gridColor = gridColor
        self.dataColor = dataColor
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                RegularPolygon(sides: 5)
//                    .fill(Color.red)
                    .fill(colorScheme == .dark ? Color(red: 50/255, green: 50/255, blue: 50/255, opacity: 0.8) : Color(red: 248/255, green: 248/255, blue: 248/255))
                    .frame(width: geo.size.width, height: geo.size.height)
                    .scaleEffect(0.8)
                
                    
                    
                
            
                RadarChartGrid(categories: data.count, divisions: 5, size: geo.size.width)
                .stroke(gridColor, lineWidth: 1.toScreenSize())
            
            
                RadarChartPath(data: [20, 15, 10, 5, 7], size: geo.size.width)
                .fill(RadialGradient.backGraph(size: geo.size.width))
            
                RadarChartPath(data: [20, 15, 10, 5, 7], size: geo.size.width)
                .stroke(Color(red: 120/255, green: 224/255, blue: 144/255), lineWidth: 1.toScreenSize())
            
                RadarChartPath(data: data, size: geo.size.width)
                    .fill(RadialGradient.frontGraph(size: geo.size.width))
            
            
            
            
                RadarChartPath(data: data, size: geo.size.width)
                .stroke(Color(red: 104/255, green: 194/255, blue: 189/255), lineWidth: 1.toScreenSize())
            
            
            }
        }
        
    }
}

struct GraphWithOverlay: View {
    
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : Color.white
                
                RadarChart(data: [20.0, 10.0, 5.0, 12.0, 3.0])
                
                RadarGraphFrame()
                
                
                NavigationLink(destination: Text("Testo forfettario")) {
                    Text("UI/UX")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .underline()
                        .font(.system(size: 22.toFontSize()))
                }.buttonStyle(LinkButtonStyle())
                
                /*
                 
                 c = centre
                 
                 linea (C, Fine_grafico)
                 
                 rect(lato_sinistro: linea)
                 
                 dividi(rect, 50)
                 
                 */
                
                
                
                
                
                
            }
            
        }
        //.frame(width: aSize * 1.2, height: aSize * 1.2)
        
    }
    
}


struct RadarChartGrid: Shape {
    let categories: Int
    let divisions: Int
    let size: CGFloat
    
    
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.maxX - rect.midX, rect.maxY - rect.midY) - (size/10)
        let stride = radius / CGFloat(divisions)
        var path = Path()
        
        for category in 1 ... categories {
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX + cos(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * radius * 1.2,
                                     y: rect.midY + sin(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * radius * 1.2))
            
            
        }
        
        for step in 1 ... divisions {
            let rad = CGFloat(step) * stride
            path.move(to: CGPoint(x: rect.midX + cos(-.pi / 2) * rad,
                                  y: rect.midY + sin(-.pi / 2) * rad))
            
            for category in 1 ... categories {
                path.addLine(to: CGPoint(x: rect.midX + cos(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * rad,
                                         y: rect.midY + sin(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * rad))
            }
        }
        
        return path
    }
}

struct RadarChartPath: Shape {
    let data: [Double]
    let size: CGFloat
    
    func path(in rect: CGRect) -> Path {
        guard
            3 <= data.count,
            let minimum = data.min(),
            0 <= minimum,
            let maximum = data.max()
        else { return Path() }
        
        let radius = min(rect.maxX - rect.midX, rect.maxY - rect.midY) - (size/10)
        var path = Path()
        
        for (index, entry) in data.enumerated() {
            switch index {
            case 0:
                path.move(to: CGPoint(x: rect.midX + CGFloat(entry / maximum) * cos(CGFloat(index) * 2 * .pi / CGFloat(data.count) - .pi / 2) * radius,
                                      y: rect.midY + CGFloat(entry / maximum) * sin(CGFloat(index) * 2 * .pi / CGFloat(data.count) - .pi / 2) * radius))
                
            default:
                path.addLine(to: CGPoint(x: rect.midX + CGFloat(entry / maximum) * cos(CGFloat(index) * 2 * .pi / CGFloat(data.count) - .pi / 2) * radius,
                                         y: rect.midY + CGFloat(entry / maximum) * sin(CGFloat(index) * 2 * .pi / CGFloat(data.count) - .pi / 2) * radius))
            }
        }
        path.closeSubpath()
        return path
    }
}

struct RadarChartView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        GraphWithOverlayAndBackground()
            .frame(width: 500, height: 500)
            
            
    }
}

struct GraphWithOverlayAndBackground: View {
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        GeometryReader { geo in
        ZStack {
            (colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : Color.white)
                .frame(width: geo.size.width, height: geo.size.height)
            
            GraphWithOverlay()
                .frame(width: geo.size.width*0.7, height: geo.size.height*0.7)
        }
            
        }
    }
}



extension RadialGradient {
    static func frontGraph(size: CGFloat) -> RadialGradient  {
        let colors = Gradient(colors: [Color(red: 57/255, green: 172/255, blue: 169/255, opacity: 0.5), Color(red: 6/255, green: 153/255, blue: 146/255, opacity: 1)])
        
        return RadialGradient(gradient: colors, center: .center, startRadius: 50, endRadius: size/2)
        
    }
    
    static func backGraph(size: CGFloat) -> RadialGradient  {
        let colors = Gradient(colors: [Color(red: 183/255, green: 232/255, blue: 148/255, opacity: 0.5), Color(red: 120/255, green: 224/255, blue: 144/255, opacity: 1)])
        
        return RadialGradient(gradient: colors, center: .center, startRadius: 50, endRadius: size/2)
        
    }
}
