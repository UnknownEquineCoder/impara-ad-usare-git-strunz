//
//  JourneyMainView.swift
//  LJM
//
//  Created by Laura Benetti on 02/12/2020.
//

import Foundation
import SwiftUI
import Combine
import JWTDecode
import SwiftKeychainWrapper

struct MainScreen: View{
    
    @AppStorage("log_Status") var status = false
    
    @EnvironmentObject var user: FrozenUser
    
    var body: some View {

        if user.loginKey == nil || user.loginKey == "" {
            if status {
                ContentView()
            } else {
                LoginView()
            }
        } else {
            // decode token
            if status {
                ContentView()
            } else {
                decodeTokenAndNavigateToView(secretToken: user.loginKey!)
            }
        }
    }
    
    func decodeTokenAndNavigateToView(secretToken: String) -> AnyView {
        
        var viewToGo = AnyView(LoginView())
        let semaphore = DispatchSemaphore(value: 0)
                
        Webservices.decodeToken(secretToken: secretToken) { user, err in
            if err == nil {
                self.user.name = user.name
                self.user.surname = user.surname
                viewToGo = AnyView(ContentView())
                semaphore.signal()
            } else {
                viewToGo = AnyView(LoginView())
                semaphore.signal()
            }
        }
        semaphore.wait()
        return viewToGo
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
