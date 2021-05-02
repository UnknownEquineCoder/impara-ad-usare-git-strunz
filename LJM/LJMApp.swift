import SwiftUI
import CoreData

@main
struct LJMApp: App {
        
    @StateObject var userAuth = UserAuth()

    //    let context = PersistentContainerWrapper()
  //  @EnvironmentObject var userAuth: UserAuth
    
    var body: some Scene {
        
        WindowGroup {
            //   MainScreen().environmentObject(userAuth)
                
        //     ContentView()
            
            LoginView()
            
            //             ContentView()
            //                .environment(\.managedObjectContext, context.container.viewContext)
        }

        WindowGroup("LoginPage") {
            WebviewLogin(url: "https://ljm-dev-01.fed.it.iosda.org/api/auth/saml/login").environmentObject(userAuth)
        }.handlesExternalEvents(matching: Set(arrayLiteral: "*"))
    }
}
