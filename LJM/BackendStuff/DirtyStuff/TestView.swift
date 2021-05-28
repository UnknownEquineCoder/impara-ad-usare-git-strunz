import SwiftUI

struct TestView: View {
    
    @State var error = "AAAAAAAAAAAAAAAAAAAAA"
    
    @State var value = 0
    
    @ObservedObject var aStorage = LJM.SyncDictionary<LearningObjective>([])
    
    var body: some View {
        VStack {
            
            Text("\(aStorage.rawData.compactMap { $0.assessments}.count)").padding(50)
            
            Button("+") {
                aStorage.refresh()
            }.padding(50)
            
            Button("-") {
                value += 1
                
                LJM.api.update(fromID: "bdf7g7hs727sdgwdgs", with: Assessment(id: "bdf7g7hs727sdgwdgs", value: value, date: "\(Date())", learningObjectiveId: "607e9c16fd4112006dc9d2fc", learnerId: "0", __v: 0))
            }
            
            List {
                ForEach(aStorage.rawData.compactMap { $0.assessments }, id: \.self) { obj in
                    Text(obj.description)
                }
            }
        }.onAppear {
            aStorage.refresh()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
