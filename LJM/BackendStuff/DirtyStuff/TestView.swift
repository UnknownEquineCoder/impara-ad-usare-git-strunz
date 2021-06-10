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

@frozen enum Stores {
    @Sync static var learningObjectives = LJM.Dictionary<LearningObjective>()
    @Sync static var learningPaths = LJM.Dictionary<LearningPath>()
    @Sync static var assessments = LJM.Dictionary<Assessment>()
    @Sync static var strands = LJM.Dictionary<Strand>()
}
