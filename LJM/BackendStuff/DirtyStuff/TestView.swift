import SwiftUI

struct TestView: View {
    
    @ObservedObject var storage = LJM.storage
    @State var counter = 0
    @State private var dummyData = [LearningObjective]()
    
    var body: some View {
        VStack {
            Text(storage.learningObjectives.count > 0 ? storage.learningObjectives[0].id ?? "undefined" : "still to update").padding(50)
            
            Text("\(counter)")

            Button("+") {
//                storage.learningObjectives.append(LearningObjective())
//                LJM.Caches.updateCache(LearningObjective.self, value: storage.learningObjectives)
//                counter += 1
                
                storage.learningObjectives[0] = LearningObjective(id: "\(counter)")
                counter += 1

            }.padding(50)
            
            Button("-") {
                counter += 1
            }.padding(50)
        }.onAppear {
            storage.learningObjectives.append(LearningObjective())
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
