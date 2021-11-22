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
    
    var name = "Name"
    
    static var container: NSPersistentCloudKitContainer = {
        
        let container = NSPersistentCloudKitContainer(name: "StudentData")
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No Description found")
        }
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
        return container
    }()

    var fetched_Learning_Objectives : FetchedResults<EvaluatedObject>? = nil
    var fetched_Profile : FetchedResults<Student>? = nil
    
    
    /// function for update the profile
    
    func update_Profile(image : Data?, name : String){
        let context = PersistenceController.container.viewContext
        
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
        let context = PersistenceController.container.viewContext
         
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
    
    /// it will take a learning objective that have to be deleted from the database and it will delete it
    
    func delete(l_Objective : learning_Objective){
        // create the correct context of the core data
        let context = PersistenceController.container.viewContext
        
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
