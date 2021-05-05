import SwiftUI

struct TestView: View {
    
    @ObservedObject var storage = LJM.storage
    @State var error = "AAAAAAAAAAAAAAAAAAAAA"
    
    var data: Set<String> {
        return Set(storage.learningObjectives.map {$0.strand?.strand ?? "Undefined"})
    }
    
    var body: some View {
        VStack {
            
            Text(error).padding(50)
            
            Button("+") {
                
            }.padding(50)
            
            List {
                ForEach(Array(data), id: \.self) { obj in
                    Text(obj)
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
