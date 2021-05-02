import SwiftUI

struct TestView: View {
    
    @ObservedObject var storage = LJM.storage
    @State var counter = 0
    @State private var dummyData = [LearningObjective]()
    
    var body: some View {
        VStack {
            Text("\(storage.learningObjectives.count)").padding(50)
            
            Text("\(counter)")
            
            Button("+") {
                dummyData.append(LearningObjective())
                LJM.Caches.updateCache(LearningObjective.self, value: dummyData)
                counter += 1
            }.padding(50)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
