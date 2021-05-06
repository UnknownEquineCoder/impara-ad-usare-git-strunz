import SwiftUI
import CoreData
import SwiftKeychainWrapper

@main
struct LJMApp: App {
        
    @AppStorage("log_Status") var status = false
    
    @AppStorage("webview_error") var webViewError: String = ""
    
    @StateObject var user = FrozenUser(name: "", surname: "")
    
    @State var webViewGotError: Bool = false
    
    var body: some Scene {
        WindowGroup {
            //     ContentView()
            
            //     LoginView()
            
            // MainScreen used as a Splash screen -> redirect to Login view or Content view regarding the login status
            MainScreen().onAppear {
                status = false
            }.environmentObject(user)
        }
        
        WindowGroup("LoginPage") {
            WebviewLogin(url: "https://ljm-dev-01.fed.it.iosda.org/api/auth/saml/login", error: $webViewGotError)
                .environmentObject(user)
                .alert(isPresented: $webViewGotError, content: {
                    Alert(title: Text("Error"), message: Text(webViewError))
                })
        }.handlesExternalEvents(matching: Set(arrayLiteral: "*"))
    }
}
