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

class WebviewCoordinator: NSObject, WKNavigationDelegate {
    @AppStorage("log_Status") var status: Bool = false
    @AppStorage("webview_error") var webViewError = ""
    
    var parent: WebviewLogin
    var error: Binding<Bool>
    
    init(_ uiWebView: WebviewLogin, error: Binding<Bool>) {
        self.parent = uiWebView
        self.error = error
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.error.wrappedValue.toggle()
        
        var message = error.localizedDescription
        message += "\nThis is usually a problem with the VPN, check if you are connected, otherwise contact an admininstrator."
        
        self.webViewError = message
    }
}

extension WebviewCoordinator: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "userLogin"{
            print(message.body)
            let dict = message.body as! [String:AnyObject]
            let secretToken = dict["secretToken"] as! String
            
            // STORE KEYCHAIN TOKEN
            
            LJM.storage.user.loginKey = secretToken
            
            Webservices.decodeToken(secretToken: secretToken) { user, err in
                // User object and fill it
                if err == nil && user != nil {
                    
                    print(secretToken)
                    // User object and fill it
                    LJM.storage.user.name = user!.name
                    LJM.storage.user.surname = user!.surname
                    
                    // switch screen to main if there is a token
                    self.status = true
                    
                    // close webview window
                    NSApplication.shared.keyWindow?.close()
                } else {
                    self.status = false
                    
                    // close webview window
                    NSApplication.shared.keyWindow?.close()
                }
            }
        }
    }
}
