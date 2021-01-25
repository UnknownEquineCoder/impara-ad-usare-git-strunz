//
//  LJMApp.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import SwiftUI
import CoreData

@main
struct LJMApp: App {
    
//    let context = PersistentContainerWrapper()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, context.container.viewContext)
        }
    }
}
