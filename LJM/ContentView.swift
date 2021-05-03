//
//  ContentView.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var status = false
    
    @StateObject var strandsStore = StrandsStore()
    @StateObject var learningPathsStore = LearningPathStore()
    
    var body: some View {
        Sidebar()
            .environmentObject(strandsStore)
            .environmentObject(learningPathsStore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
