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
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        if status {
            ContentView().frame(width: NSScreen.screenWidth, height: NSScreen.screenHeight, alignment: .center)
        } else {
            LoginView().frame(width: NSScreen.screenWidth, height: NSScreen.screenHeight, alignment: .center)
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
