import SwiftUI

struct TestView: View {
    
    @State var error = "AAAAAAAAAAAAAAAAAAAAA"
    
    
    var body: some View {
        List {
            ForEach(Stores.learningObjectives.rawData, id: \.id) {
                Text("\($0.description ?? "No description")")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}


