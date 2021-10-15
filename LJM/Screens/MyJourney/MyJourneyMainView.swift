//
//  MyJourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 20/04/2021.
//

import SwiftUI

struct MyJourneyMainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showSearchBarSideBar = true
    
    @Binding var selectedMenu: OutlineMenu
        
    //new data flow
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MyJourneyView(selectedMenu: $selectedMenu)
                .modifier(PaddingMainSubViews())
            
        }.background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
    }
}

struct MyJourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyJourneyMainView(selectedMenu: .constant(.journey))
    }
}
