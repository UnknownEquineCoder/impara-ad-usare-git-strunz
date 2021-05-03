import SwiftUI
import CoreData
import SwiftKeychainWrapper

@main
struct LJMApp: App {
        
    @AppStorage("log_Status") var status = false
    
    var body: some Scene {
        
        WindowGroup {
        //     ContentView()
            
        //     LoginView()
            
            // MainScreen used as a Splash screen -> redirect to Login view or Content view regarding the login status
            MainScreen().onAppear {
                status = false
            }
        }

        WindowGroup("LoginPage") {
            WebviewLogin(url: "https://ljm-dev-01.fed.it.iosda.org/api/auth/saml/login")
        }.handlesExternalEvents(matching: Set(arrayLiteral: "*"))
    }
}
