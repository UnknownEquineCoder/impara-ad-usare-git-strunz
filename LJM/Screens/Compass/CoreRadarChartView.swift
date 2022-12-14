import SwiftUI
import Shapes

struct CoreRadarChartView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var data_Front_Array : [CGFloat]
    @Binding var data_Back_Array : [CGFloat]
    @Binding var animation_Trigger : Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                CoreRadarChart(gridColor: Color.gray, data_Front_Array: $data_Front_Array, data_Back_Array: $data_Back_Array, animation_Trigger: $animation_Trigger)
                
                RadarGraphFrame()
                
                VStack(alignment: .leading, spacing: 37.0){
                    label("PROGRESSING")
                    label("BEGINNING")
                    label("NOT EVALUATED")
                }
                .padding(.bottom, (geo.size.height/1.90)+5)
                .padding(.leading, 10)
            }
        }
    }
    
    func label(_ text: String) -> some View {
        Text(text)
            .fontWeight(.light)
            .font(.system(size: 10))
            .foregroundColor(Color.gray46)
            .multilineTextAlignment(.leading)
            .padding(.leading, 80)
    }
}

struct CoreRadarChartGrid: Shape {
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

struct CoreRadarChartPath: Shape {
    let data: [CGFloat]
    let size: CGFloat
    let maximum: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let radius = min(rect.maxX - rect.midX, rect.maxY - rect.midY) - (size/10)
        var path = Path()
        
        for (index, entry) in data.enumerated() {
            switch index {
            case 0:
                withAnimation {
                    let _X = rect.midX + CGFloat(entry / 60) * cos(CGFloat(index) * 2 * CGFloat.pi / CGFloat(data.count) - CGFloat.pi / 2) * radius
                    
                    let _Y = rect.midY + CGFloat(entry / 60) * sin(CGFloat(index) * 2 * CGFloat.pi / CGFloat(data.count) - CGFloat.pi / 2) * radius
                    
                    path.move(to: CGPoint(x: _X,
                                          y: _Y))
                }
                
                
            default:
                withAnimation {
                    let _X = rect.midX + CGFloat(entry / 60) * cos(CGFloat(index) * 2 * CGFloat.pi / CGFloat(data.count) - CGFloat.pi / 2) * radius
                    
                    let _Y = rect.midY + CGFloat(entry / 60) * sin(CGFloat(index) * 2 * CGFloat.pi / CGFloat(data.count) - CGFloat.pi / 2) * radius
                    
                    path.addLine(to: CGPoint(x: _X,
                                             y: _Y))
                }
                
            }
        }
        path.closeSubpath()
        return path
    }
}


struct CoreRadarCompositeGrid: View {
    var size: CGFloat
    var data: [CGFloat]
    var b_color: Color
    var f_color: RadialGradient
    var max: CGFloat
    
    var body: some View {
        ZStack {
            CoreRadarChartPath(data: data, size: size, maximum: max)
                .fill(f_color)
            
            CoreRadarChartPath(data: data, size: size, maximum: max)
                .stroke(b_color, lineWidth: 1.toScreenSize())
        }
    }
}

struct CoreRadarChart: View {
    let gridColor: Color
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var data_Front_Array : [CGFloat]
    @Binding var data_Back_Array : [CGFloat]
    @Binding var animation_Trigger : Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                RegularPolygon(sides: 5)
                    .fill(colorScheme == .dark ? Color(red: 50/255, green: 50/255, blue: 50/255, opacity: 0.8) : Color(red: 248/255, green: 248/255, blue: 248/255))
                    .frame(width: geo.size.width, height: geo.size.height)
                    .scaleEffect(0.8)
                
                CoreRadarChartGrid(categories: data_Front_Array.count, divisions: 3, size: geo.size.width)
                    .stroke(gridColor, lineWidth: 1.toScreenSize())
                
                CoreRadarCompositeGrid(size: geo.size.width, data: data_Front_Array, b_color: colorScheme == .dark ? Color.back_graph_dark_mode : Color.back_graph_light_mode, f_color: colorScheme == .dark ? RadialGradient.backGraphDarkMode(size: geo.size.width) : RadialGradient.backGraphLightMode(size: geo.size.width), max: CGFloat(60))
                    .scaleEffect(animation_Trigger ? 1 : 0, anchor: .center)
                    .animation(.easeInOut(duration: 0.25))

                CoreRadarCompositeGrid(size: geo.size.width, data: data_Back_Array, b_color: colorScheme == .dark ? Color.front_graph_dark_mode : Color.front_graph_light_mode, f_color: colorScheme == .dark ? RadialGradient.frontGraphDarkMode(size: geo.size.width) : RadialGradient.frontGraphLightMode(size: geo.size.width), max: CGFloat(60))
                    
            }
        }
    }
}
