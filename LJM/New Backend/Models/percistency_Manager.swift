//
//  Persistence.swift
//  peppe
//
//  Created by denys pashkov on 27/10/21.
//

import CoreData
import SwiftUI

extension EvaluatedObject{
    static func get_Evaluated_Object_List_Request() -> NSFetchRequest<EvaluatedObject>{
        let request : NSFetchRequest<EvaluatedObject> = EvaluatedObject.fetchRequest()
        
        request.sortDescriptors = []
        
        return request
    }
}

extension Student{
    static func get_Student_Request() -> NSFetchRequest<Student>{
        let request : NSFetchRequest<Student> = Student.fetchRequest()
        
        request.sortDescriptors = []
        
        return request
    }
}

class PersistenceController {
    static var shared = PersistenceController()
    
    //    var name = "Name"
    
    //    static var container: NSPersistentContainer = {
    //
    //        let container = NSPersistentContainer(name: "StudentData")
    //
    ////        guard let description = container.persistentStoreDescriptions.first else {
    ////            fatalError("No Description found")
    ////        }
    ////        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
    //
    //        container.loadPersistentStores { description, error in
    //            if let error = error {
    //                fatalError("Unable to load persistent stores: \(error)")
    //            }
    //        }
    //
    ////        container.viewContext.automaticallyMergesChangesFromParent = true
    ////        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    //
    //        return container
    //    }()
    //
    //    var fetched_Learning_Objectives : FetchedResults<EvaluatedObject>? = nil
    //    var fetched_Profile : FetchedResults<Student>? = nil
    
    var name = "Name"
    
    let container: NSPersistentCloudKitContainer
    
    var fetched_Learning_Objectives : FetchedResults<EvaluatedObject>? = nil
    var fetched_Profile : FetchedResults<Student>? = nil
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "StudentData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    
    /// function for update the profile
    
    func update_Profile(image : Data?, name : String){
        let context = PersistenceController.shared.container.viewContext
//        PersistenceController.container.viewContext
        self.name = name
        
        do{
            let fetched_Data = try context.fetch(Student.get_Student_Request())
            
            for objective in fetched_Data {
                context.delete(objective)
            }
            
        } catch {
            fatalError("Unsolver Error during a fetch in evaluated learning objective function")
        }
        
        let new_Student = Student(context: context)
        
        new_Student.name = name
        
        if let image_To_Save = image {
            new_Student.image = image_To_Save as NSObject
        }
        
        do {
            // save the context with new element added
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
    
    /// this function will have to be called when a learning objective is evaluated in any way or form
    ///
    /// It will delete old evaluation for that learnin objective and will save the new one
    
    func evalutate_Learning_Objective(l_Objective : learning_Objective){
        // create the correct context of the core data
        let context = PersistenceController.shared.container.viewContext
        
        do{
            let fetched_Data = try context.fetch(EvaluatedObject.get_Evaluated_Object_List_Request())
            
            for objective in fetched_Data {
                
                if objective.id == l_Objective.ID {
                    context.delete(objective)
                }
            }
            
        } catch {
            fatalError("Unsolver Error during a fetch in evaluated learning objective function")
        }
        
        // declering the new object that is evaluated
        let new_Evaluated_Object = EvaluatedObject(context: context)
        
        // assigning to the new object the values that it will have
        new_Evaluated_Object.id = l_Objective.ID
        new_Evaluated_Object.eval_Dates = l_Objective.eval_date as NSObject
        new_Evaluated_Object.eval_Scores = l_Objective.eval_score as NSObject
        
        // check for objectives saved if this one was alredy evaluated, if it was alredy evaluated
        // it will delete the old evaluation
        
        
        
        if context.hasChanges {
            do {
                // save the context with new element added
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    /// this function will be called for fetch the resoults and will return the array of evaluated objects present on core data
    ///
    /// it will return a easier format to work with
    
    func load(objectives : FetchedResults<EvaluatedObject>) -> [CD_Evaluated_Object]{
        // create a temporary array that will be returned
        var temp_Evaluated_Objects : [CD_Evaluated_Object] = []
        
        // for every evaluated object saved it will create a new instance of CD_Evaluated_Object and append to the array
        for objective in objectives {
            let temp = CD_Evaluated_Object.init(
                id: objective.id!,
                eval_Date: objective.eval_Dates as? [Date] ?? [],
                eval_Score: objective.eval_Scores as? [Int] ?? []
            )
            
            temp_Evaluated_Objects.append(temp)
        }
        
        //return the array of CD_Evaluated_Object
        return temp_Evaluated_Objects
    }
    
    /// this function will take an array of data of learning objective and override the datas saved on cloudkit
    
    func override_Data(rows : [String]){
        // create the correct context of the core data
        let context = PersistenceController.shared.container.viewContext
        
        // Delete all the learning Objectives that was saved before
        
        do{
            let fetched_Data = try context.fetch(EvaluatedObject.get_Evaluated_Object_List_Request())
            
            for objective in fetched_Data {
                
                context.delete(objective)
                
            }
            
        } catch {
            fatalError("Unsolver Error during a fetch in evaluated learning objective function")
        }
        
        // taking the row data and transforming in a data that is possible to save
        for row in rows {
            // declering the new object that is evaluated
            let new_Evaluated_Object = EvaluatedObject(context: context)
            
            let row_Data = row.components(separatedBy: ",")
            
            let eval_Date_Row = row_Data[2].components(separatedBy: "-")
            let eval_score_Row = row_Data[1].components(separatedBy: "-")
            
            var converted_Eval_Date : [Date] = []
            var converted_Eval_Score : [Int] = []
            
            for index in 0..<eval_score_Row.count {
                converted_Eval_Date.append(Date(timeIntervalSince1970: Double(eval_Date_Row[index])!))
                converted_Eval_Score.append(Int(eval_score_Row[index])!)
            }
            
            // assigning to the new object the values that it will have
            new_Evaluated_Object.id = row_Data[0]
            new_Evaluated_Object.eval_Dates = converted_Eval_Date as NSObject
            new_Evaluated_Object.eval_Scores = converted_Eval_Score as NSObject
        }
        
        // save if there are any update
        if context.hasChanges {
            do {
                // save the context with new element added
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
    }
    
    /// it will take a learning objective that have to be deleted from the database and it will delete it
    
    func delete(l_Objective : learning_Objective){
        // create the correct context of the core data
        let context = PersistenceController.shared.container.viewContext
        
        // check for objectives saved if this one was alredy evaluated, if it was alredy evaluated
        // it will delete the old evaluation
        
        do{
            let fetched_Data = try context.fetch(EvaluatedObject.get_Evaluated_Object_List_Request())
            
            for objective in fetched_Data {
                
                if objective.id == l_Objective.ID {
                    context.delete(objective)
                }
            }
            
        } catch {
            fatalError("Unsolver Error during a fetch in evaluated learning objective function")
        }
        
        // if the context was changed it will update
        if context.hasChanges {
            
            do {
                
                // save the context with new element added
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
