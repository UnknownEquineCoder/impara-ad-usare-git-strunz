import Foundation
import SwiftUI

struct RadarGraphFrame: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let categories = 5
    let divisions = 5
    
    let ballsColors: [ColorData] =
    [
        ColorData(212, 69, 27),
        ColorData(255, 171, 7),
        ColorData(59, 100, 244),
        ColorData(102, 175, 45),
        ColorData(144, 28, 146)
    ]

    let strandLabels: [String] = ["PROCESS", "PROFESSIONAL SKILLS", "TECHNICAL", "DESIGN", "BUSINESS"]
    
    var body: some View{
        GeometryReader { geo in
            ZStack {
                ForEach(getPointCenters(rect: geo.size),
                        id: \.self) { data in
                    CircleAroundAPoint().path(around: data.toCG(), with: CGSize(width: 12, height: 12))
                        .foregroundColor(Color(from: data.cData))
                }
                
                ForEach(0..<getLabel(rect: geo.size).count,
                        id: \.self) { data in
                    let point = getLabel(rect: geo.size)[data]
                    Text(strandLabels[data])
                        .position(x: point.x, y: point.y)
                        .foregroundColor(Color(from: point.cData))
                        .font(.system(size: 14.toFontSize(), weight: .light))
                }
            }
        }
    }
    
    func getLabel(rect: CGSize) -> [APoint] {
        
        var ret = [APoint]()
        
        let radius = min(rect.width/2, rect.height/2) - rect.width/31
        
        for category in 1 ... categories {
            
            let _X = rect.width/2 + cos(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * radius * 1.2
            
            let _Y = rect.height/2 + sin(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * radius * 1.2
            
            ret.append(
                APoint(
                    x: _X,
                    y: _Y,
                    cData: ballsColors[category-1]
                )
            )
        }
        return ret
    }
    
    func getPointCenters(rect: CGSize) -> [APoint] {
        
        var ret = [APoint]()
        
        let radius = min(rect.width/2, rect.height/2) - rect.width/10
        
        for category in 1 ... categories {
            
            let _X = rect.width/2 + cos(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * radius * 1.2
            
            let _Y = rect.height/2 + sin(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * radius * 1.2
            
            ret.append(
                APoint(
                    x: _X,
                    y: _Y,
                    cData: ballsColors[category-1]
                )
            )
        }
        return ret
    }
}

struct ColorData: Hashable, Codable {
    typealias N = Double
    
    var R: N
    var G: N
    var B: N
    
    init(_ R: N, _ G: N, _ B: N) {
        self.R = R
        self.G = G
        self.B = B
    }
}

extension Color {
    init(from Data: ColorData) {
        self.init(red: Data.R/255, green: Data.G/255, blue: Data.B/255)
    }
}



struct APoint: Hashable {
    var x: CGFloat
    var y: CGFloat
    var cData: ColorData
    
    func toCG() -> CGPoint {
        return CGPoint(x: x, y: y)
    }
}

struct RadarGraphFrame_Previews: PreviewProvider {
    static var previews: some View {
        RadarGraphFrame()
            .frame(width: 500, height: 500)
    }
}
