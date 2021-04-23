//
//  WebviewLogin.swift
//  LJM
//
//  Created by Tony Tresgots on 21/04/2021.
//

import Foundation
import SwiftUI
import WebKit
import SwiftKeychainWrapper

struct WebviewLogin: NSViewRepresentable {
    
    @EnvironmentObject var userAuth: UserAuth
    
    var url : String
    
    func makeNSView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
                                
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        
        wkWebView.configuration.userContentController.add(ContentController(), name: "userLogin")

        return wkWebView
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}

class ContentController: NSObject, WKScriptMessageHandler {
    @EnvironmentObject var userAuth: UserAuth
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "userLogin"{
            print(message.body)
            let dict = message.body as! [String:AnyObject]
            let secretToken = dict["secretToken"] as! String
            
            let saveAccessToken: Bool = KeychainWrapper.standard.set(secretToken, forKey: "tokenAuth")
            // STORE KEYCHAIN TOKEN
        }
    }
}
