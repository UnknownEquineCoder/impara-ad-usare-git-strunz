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
    
    func updateNSView(_ wkWebView: WKWebView, context: Context) {}
}
