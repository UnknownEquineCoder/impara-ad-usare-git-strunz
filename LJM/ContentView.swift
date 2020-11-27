//
//  ContentView.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        JourneyMainView()
            .frame(width: 1000, height: 600)
            .padding(50)
            .background(Color.white)
        
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
