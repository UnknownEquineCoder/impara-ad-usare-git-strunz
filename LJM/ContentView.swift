import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var status = false
    
//    @StateObject var strandsStore = StrandsStore()
//    @StateObject var learningPathsStore = LearningPathStore()

    var body: some View {
//        Sidebar()
        TestView()
            .frame(width: NSScreen.screenWidth, height: NSScreen.screenHeight, alignment: .center)
//            .environmentObject(strandsStore)
//            .environmentObject(learningPathsStore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
