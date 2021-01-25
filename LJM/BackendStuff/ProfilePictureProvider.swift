////
////  ProfilePictureProvider.swift
////  LJM
////
////  Created by Laura Benetti on 10/12/20.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//import AppKit
//
//class ProPicDataProvider{
//    @FetchRequest(
//        entity: ProfilePicture.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \ProfilePicture.addedAt, ascending: false)
//        ]
//    ) private var sortedData: FetchedResults<ProfilePicture>
//    
//    lazy var latestProPicData = {
//        sortedData[0]
//    }()
//    
//    private init() {}
//    
//    static var shared: ProPicDataProvider = {
//        ProPicDataProvider()
//    }()
//}
//
//
//
//class ContainerWrapper{
//    
//    lazy var persistentContainer: NSPersistentContainer = {
//        // 2
//        let container = NSPersistentContainer(name: "FaveFlicks")
//        // 3
//        container.loadPersistentStores { _, error in
//            // 4
//            if let error = error as NSError? {
//                // You should add your own error handling code here.
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//        return container
//    }()
//    
//    func saveContext() {
//        // 1
//        let context = persistentContainer.viewContext
//        // 2
//        if context.hasChanges {
//            do {
//                // 3
//                try context.save()
//            } catch {
//                // 4
//                // The context couldn't be saved.
//                // You should add your own error handling here.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//}
//
//
//func imageFrom(url: String) {
//    guard let image = NSImage(named: url) else {
//        return
//    }
//    
//    let tiff = image.tiffRepresentation
//    // create image with data
//    let propic: ProfilePicture = ProfilePicture(context: <#T##NSManagedObjectContext#>)
//}
//
//class PersistentContainerWrapper {
//    let container = NSPersistentContainer(name: "LJM")
//    
//    
//}
