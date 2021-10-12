import SwiftUI
import Shapes

struct GraphWithOverlay: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geo in
            ZStack {
                colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : Color.white
                
                RadarChart(provider: GraphDataProvider.from_API(type: .core), gridColor: Color.gray)
                
                RadarGraphFrame()
                
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
    var type: GraphTypes
    var front_data: [CGFloat]
    var back_data: [CGFloat]
    
    
    private init(_ front_data: [CGFloat], _ back_data: [CGFloat], type: GraphTypes) {
        self.front_data = front_data
        self.back_data = back_data
        self.type = type
    }
    
    static func placeholder(type: GraphTypes) -> GraphDataProvider {
        return GraphDataProvider([10, 20, 30, 40, 50], [60, 70, 80, 90, 100], type: type)
    }
    
    static func from_API(type: GraphTypes) -> GraphDataProvider {
        
        var data = [CGFloat]()
        #warning("TODO: REWORK WITH NEW DATA STRUCTURE")
        // we filter the data based on core vs elective
        let unrefined_data = Stores.learningObjectives.rawData.filter { $0.isCore() == (type == .core) }
        
        for strand in Strands.allCases {
            // we take 1 strand per iteration
            let strand_data = unrefined_data.filter { $0.strand ?? "" == strand.rawValue }
            // we remove nil scores and only take into account
            // the most recent change
            let last_scores = strand_data.compactMap { $0.assessments?.last?.score }
            // we get the total of the scores
            let strand_sum = CGFloat(last_scores.reduce(0, +))
            // we append the total to the array
            data.append(strand_sum)
        }
        return GraphDataProvider(data, (1...5).map( {_ in CGFloat(Int.random(in: 20...99))} ), type: type)
    }
    
    func max() -> CGFloat {
        return Swift.max(CGFloat(Stores.learningObjectives.rawData.filter { $0.isCore() == (type == .core) }.count) * 5, CGFloat(100))
    }
    
    enum GraphTypes {
        case core
        case elective
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







extension Array where Element: Identifiable {
    mutating func update(with value: Element) {
        if let row = self.firstIndex(where: {$0.id == value.id}) {
               self[row] = value
            
        }
    }
}

extension Array where Element: LJMCodableData {
    mutating func updateAndRefresh(with value: Element, code: ()->()) {
        update(with: value)
        code()
    }
}

extension Array where Element == LearningObjective {
    mutating func updateAssessments(with assessment: Assessment, on objective: LearningObjective) {
        
        var newObjective = objective
        newObjective.assessments?.append(assessment)
        
        updateAndRefresh(with: objective) {
            #warning("Implement update")
        }
    }
}
