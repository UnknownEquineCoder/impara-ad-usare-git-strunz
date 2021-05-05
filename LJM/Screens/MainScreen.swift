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
        
    var body: some View {

        if LJM.storage.user.loginKey == nil || LJM.storage.user.loginKey == "" {
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
                decodeTokenAndNavigateToView(secretToken: (LJM.Storage.shared.user.loginKey)!)
            }
        }
    }
    
    func decodeTokenAndNavigateToView(secretToken: String) -> AnyView {
        
        var viewToGo = AnyView(LoginView())
        let semaphore = DispatchSemaphore(value: 0)
                
        Webservices.decodeToken(secretToken: secretToken) { user, err in
            if err == nil {
                LJM.storage.user.name = user.name
                LJM.storage.user.surname = user.surname
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
