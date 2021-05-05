import SwiftUI
import CoreData

@main
struct LJMApp: App {
    
//    let context = PersistentContainerWrapper()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 1920.toScreenSize(), height: 1080.toScreenSize())
                .onAppear {
                    Webservices.getGraph(date_to: "2020/01/01", path: "UI/UX")
                }
//                .environment(\.managedObjectContext, context.container.viewContext)
        }
    }
}
