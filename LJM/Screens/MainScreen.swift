//
//  JourneyMainView.swift
//  LJM
//
//  Created by Laura Benetti on 02/12/2020.
//

import Foundation
import SwiftUI

struct MainScreen: View{
   
    
    var body: some View {
        ZStack{
            Color.blue
            HStack{
                Sidebar()
                JourneyMainView().frame(width: 1300, height: .infinity, alignment: .leading)
            }
        }.frame(width: 1920.toScreenSize(), height: 1080.toScreenSize())
}
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

