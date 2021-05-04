import SwiftUI
import Shapes

struct GraphWithOverlay: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geo in
            ZStack {
                colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : Color.white
                
                RadarChart(provider: GraphDataProvider.placeholder(), gridColor: Color.gray)
                
                RadarGraphFrame()
                
                NavigationLink(destination: Text("Testo forfettario")) {
                    Text("UI/UX")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .underline()
                        .font(.system(size: 22.toFontSize()))
                }.buttonStyle(LinkButtonStyle())
                
                VStack(alignment: .leading, spacing: 20.0){
                    label("EXEMPLARY")
                    label("PROFICIENT")
                    label("PROGRESSING")
                    label("BEGINNING")
                }
                .padding(.bottom, geo.size.height/2.18)
            }
        }
        //.frame(width: aSize * 1.2, height: aSize * 1.2)
    }
    
    func label(_ text: String) -> some View {
        Text(text)
            .fontWeight(.light)
            .font(.system(size: 10))
            .foregroundColor(colorScheme == .dark ? Color(red: 224/255, green: 224/255, blue: 224/255) : Color(red: 46/255, green: 50/255, blue: 53/255, opacity: 0.5))
            .multilineTextAlignment(.leading)
            .padding(.leading, 80)
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
    let data: [CGFloat]
    let size: CGFloat
    let maximum: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let radius = min(rect.maxX - rect.midX, rect.maxY - rect.midY) - (size/10)
        var path = Path()
        
        for (index, entry) in data.enumerated() {
            switch index {
            case 0:
                let _X = rect.midX + CGFloat(entry / maximum) * cos(CGFloat(index) * 2 * CGFloat.pi / CGFloat(data.count) - CGFloat.pi / 2) * radius
                
                let _Y = rect.midY + CGFloat(entry / maximum) * sin(CGFloat(index) * 2 * CGFloat.pi / CGFloat(data.count) - CGFloat.pi / 2) * radius
                
                path.move(to: CGPoint(x: _X,
                                      y: _Y))
                
            default:
                let _X = rect.midX + CGFloat(entry / maximum) * cos(CGFloat(index) * 2 * CGFloat.pi / CGFloat(data.count) - CGFloat.pi / 2) * radius
                
                let _Y = rect.midY + CGFloat(entry / maximum) * sin(CGFloat(index) * 2 * CGFloat.pi / CGFloat(data.count) - CGFloat.pi / 2) * radius
                
                path.addLine(to: CGPoint(x: _X,
                                         y: _Y))
            }
        }
        path.closeSubpath()
        return path
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

extension Color {
    static let back_graph: Color = Color(red: 120/255, green: 224/255, blue: 144/255)
    static let front_graph: Color = Color(red: 104/255, green: 194/255, blue: 189/255)
}

struct GraphDataProvider {
    
    var front_data: [CGFloat]
    var back_data: [CGFloat]
    @State var all_LOs = [LearningObjective]()
    
    static func placeholder() -> GraphDataProvider {
        return GraphDataProvider(front_data: [10, 20, 30, 40, 50], back_data: [60, 70, 80, 90, 100])
    }
    
    static func from_API() -> GraphDataProvider {
        return GraphDataProvider.placeholder()
    }
    
    func max() -> CGFloat {
        return [front_data.max()!, back_data.max()!].max()!
    }
}

struct RadarCompositeGrid: View {
    var size: CGFloat
    var data: [CGFloat]
    var b_color: Color
    var f_color: RadialGradient
    var max: CGFloat
    
    var body: some View {
        ZStack {
            RadarChartPath(data: data, size: size, maximum: max)
                .fill(f_color)
            
            RadarChartPath(data: data, size: size, maximum: max)
                .stroke(b_color, lineWidth: 1.toScreenSize())
        }
    }
}

struct RadarChart: View {
    @State var provider: GraphDataProvider
    let gridColor: Color
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                RegularPolygon(sides: 5)
                    .fill(colorScheme == .dark ? Color(red: 50/255, green: 50/255, blue: 50/255, opacity: 0.8) : Color(red: 248/255, green: 248/255, blue: 248/255))
                    .frame(width: geo.size.width, height: geo.size.height)
                    .scaleEffect(0.8)
                
                RadarChartGrid(categories: provider.back_data.count, divisions: 5, size: geo.size.width)
                    .stroke(gridColor, lineWidth: 1.toScreenSize())
                
                RadarCompositeGrid(size: geo.size.width, data: provider.back_data, b_color: Color.back_graph, f_color: RadialGradient.backGraph(size: geo.size.width), max: CGFloat(provider.max()))
                
                RadarCompositeGrid(size: geo.size.width, data: provider.front_data, b_color: Color.front_graph, f_color: RadialGradient.frontGraph(size: geo.size.width), max: CGFloat(provider.max()))
            }
        }
    }
}

struct RadarChartView_Previews: PreviewProvider {
    static var previews: some View {
        GraphWithOverlayAndBackground()
            .frame(width: 500, height: 500)
    }
}
