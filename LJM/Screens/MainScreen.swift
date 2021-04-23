//
//  JourneyMainView.swift
//  LJM
//
//  Created by Laura Benetti on 02/12/2020.
//

import Foundation
import SwiftUI
import Combine

struct MainScreen: View{
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        if !userAuth.isLoggedin {
            LoginView().environmentObject(userAuth)
        } else {
            ContentView().environmentObject(userAuth)
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

class UserAuth: ObservableObject {
    
    let didChange = PassthroughSubject<UserAuth,Never>()
    
    // required to conform to protocol 'ObservableObject'
    let willChange = PassthroughSubject<UserAuth,Never>()
    
    func login() {
        // login request... on success:
        self.isLoggedin = true
    }
    
    var isLoggedin = false {
        didSet {
            didChange.send(self)
        }
        
//         willSet {
//            willChange.send(self)
//         }
    }
}
