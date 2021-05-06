import Foundation
import SwiftUI
import WebKit

struct WebviewLogin: NSViewRepresentable {
    
    var url : String
    @Binding var error: Bool
    
    // Make a coordinator to co-ordinate with WKWebView's default delegate functions
    func makeCoordinator() -> WebviewCoordinator {
        WebviewCoordinator(self, error: $error)
    }
    
    func makeNSView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        
        wkWebView.navigationDelegate = context.coordinator as WKNavigationDelegate
        wkWebView.allowsBackForwardNavigationGestures = true
        
        wkWebView.load(request)
        
        wkWebView.configuration.userContentController.add(context.coordinator as WKScriptMessageHandler, name: "userLogin")
        
        return wkWebView
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}

class ContentController: NSObject, WKScriptMessageHandler {
    
    @AppStorage("log_Status") var status: Bool = false
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "userLogin"{
            print(message.body)
            let dict = message.body as! [String:AnyObject]
            let secretToken = dict["secretToken"] as! String
            
            // STORE KEYCHAIN TOKEN
            
            KeychainWrapper.standard.set(secretToken, forKey: "tokenAuth")
            
            Webservices.decodeToken(secretToken: secretToken) { user, err in
                
                if err == nil && user != nil {
                    // User object and fill it
                    LJM.Storage.shared.user.name = user!.name
                    LJM.Storage.shared.user.surname = user!.surname
                    
                    // switch screen to main if there is a token
                    self.status = true
                    
                    // close webview window
                    NSApplication.shared.keyWindow?.close()
                } else {
                    self.status = false

                    NSApplication.shared.keyWindow?.close()
                }
            }
        }
    }
    
    func updateNSView(_ wkWebView: WKWebView, context: Context) {}
}
