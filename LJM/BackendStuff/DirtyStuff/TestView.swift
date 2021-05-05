import SwiftUI

struct TestView: View {
    
    @ObservedObject var storage = LJM.storage
    @State var error = "AAAAAAAAAAAAAAAAAAAAA"
    
    var body: some View {
        VStack {
            
            Text(error).padding(50)
            
            Button("+") {
                
            }.padding(50)
            
            List {
                ForEach(storage.learningPaths, id: \.id) { obj in
                    Text("\(obj.description ?? "Undefined")")
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
