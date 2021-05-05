import Foundation
import SwiftUI
import WebKit

struct WebviewLogin: NSViewRepresentable {
            
    var url : String
    
    // Make a coordinator to co-ordinate with WKWebView's default delegate functions
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        
        wkWebView.navigationDelegate = context.coordinator
        wkWebView.allowsBackForwardNavigationGestures = true
        
        wkWebView.load(request)
        
        wkWebView.configuration.userContentController.add(context.coordinator, name: "userLogin")

        return wkWebView
    }
    
    func updateNSView(_ wkWebView: WKWebView, context: Context) {
        wkWebView.navigationDelegate = wkWebView as? WKNavigationDelegate
    }
}
