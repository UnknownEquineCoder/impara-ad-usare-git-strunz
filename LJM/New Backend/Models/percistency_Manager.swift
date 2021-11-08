//
//  Persistence.swift
//  peppe
//
//  Created by denys pashkov on 27/10/21.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static var shared = PersistenceController()
    
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
    
    /// function for update the name
    // for update the file
    func update_Image(data : Data){
        let context = PersistenceController.shared.container.viewContext
        
        // declering the new object that is evaluated
        let new_Student = Student(context: context)
        // assigning to the new object the values that it will have
        new_Student.image = data as NSObject
        if let profile = fetched_Profile {
            
            print("$$$$$$$ \(profile.first?.name) 00 \(profile.last?.name)")
            
            if let last_Student = profile.last {
                new_Student.name = last_Student.name ?? "name"
                new_Student.cognome = last_Student.cognome ?? "surname"
                context.delete(last_Student)
            }
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
    
    /// function for update the name of the student and
    
    func update_Name(name : String){
        
        let context = PersistenceController.shared.container.viewContext
        
        // declering the new object that is evaluated
        let new_Student = Student(context: context)
        // assigning to the new object the values that it will have
        
        new_Student.name = name
        
        if let profile = fetched_Profile {
            if let last_Student = profile.last {
                new_Student.image = last_Student.image
//                context.delete(last_Student)
            }
        }
    
        do {
            // save the context with new element added
            try context.save()
            print("$$$$$$$ \(fetched_Profile?.first?.name) 00 \(fetched_Profile?.last?.name)")
            
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
    /// function for update the surname of the student and
    
    func update_Surname(surname : String, student : FetchedResults<Student>){
        
        let context = PersistenceController.shared.container.viewContext
        
        // declering the new object that is evaluated
        let new_Student = Student(context: context)
        // assigning to the new object the values that it will have
        
//        new_Student.cognome = surname
        
        if let last_Student = student.first {
            new_Student.name = last_Student.name
            new_Student.image = last_Student.image
            context.delete(last_Student)
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
        
        // declering the new object that is evaluated
        let new_Evaluated_Object = EvaluatedObject(context: context)
        
        // assigning to the new object the values that it will have
        new_Evaluated_Object.id = l_Objective.ID
        new_Evaluated_Object.eval_Dates = l_Objective.eval_date as NSObject
        new_Evaluated_Object.eval_Scores = l_Objective.eval_score as NSObject
        
        // check for objectives saved if this one was alredy evaluated, if it was alredy evaluated
        // it will delete the old evaluation
        for objective in fetched_Learning_Objectives! {
            if objective.id == new_Evaluated_Object.id {
                context.delete(objective)
            }
        }
        
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
        let context = PersistenceController.shared.container.viewContext
        
        // check for objectives saved if this one was alredy evaluated, if it was alredy evaluated
        // it will delete the old evaluation
        
        for objective in fetched_Learning_Objectives! {
            
            if objective.id == l_Objective.ID {
                
                context.delete(objective)
            }
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
