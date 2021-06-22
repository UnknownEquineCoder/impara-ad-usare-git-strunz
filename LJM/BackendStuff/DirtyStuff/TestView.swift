import SwiftUI

struct TestView: View {
    
    @State var error = "AAAAAAAAAAAAAAAAAAAAA"
    
    var body: some View {
        VStack {
            Button("print") {
                Stores.learningObjectives.rawData.forEach {
                    print($0, ",")
                }
                Stores.learningPaths.rawData.forEach {
                    print($0, ",")
                }
            }
            
            List {
                ForEach(Stores.learningObjectives.rawData, id: \.id) {
                    Text("\($0.description ?? "No description")")
                }
            }
            
            List {
                ForEach(Stores.learningPaths.rawData, id: \.id) {
                    Text("\($0.name)")
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
