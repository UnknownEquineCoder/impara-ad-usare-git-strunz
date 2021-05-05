//
//  WebviewCoordinator.swift
//  LJM
//
//  Created by Giovanni Prisco on 05/05/21.
//

import Foundation
import SwiftUI
import WebKit
import SwiftKeychainWrapper

class Coordinator : NSObject, WKNavigationDelegate {
    @AppStorage("log_Status") var status: Bool = false
    
    var parent: WebviewLogin

    init(_ uiWebView: WebviewLogin) {
        self.parent = uiWebView
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            print(response.statusCode)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
}

extension Coordinator: WKScriptMessageHandler {
    //   @EnvironmentObject var user: FrozenUser
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "userLogin"{
            print(message.body)
            let dict = message.body as! [String:AnyObject]
            let secretToken = dict["secretToken"] as! String
            
            // STORE KEYCHAIN TOKEN
            
            KeychainWrapper.standard.set(secretToken, forKey: "tokenAuth")
            
            Webservices.decodeToken(secretToken: secretToken) { user, err in
                //                // User object and fill it
                //                self.user.name = user.name
                //                self.user.surname = user.surname
                
                // switch screen to main if there is a token
                self.status = true
                
                // close webview window
                NSApplication.shared.keyWindow?.close()
            }
        }
    }
}
