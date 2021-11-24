//
//  singleton.swift
//  LJM
//
//  Created by denys pashkov on 05/10/21.
//

import Foundation
import SwiftUI

class singleton_Shared {
    static let shared = singleton_Shared()
    var profile_data : profile = profile()
    var learning_Objectives : [learning_Objective] = []
}

class LearningObjectivesStore: ObservableObject {
    
    // Published elements
    @Published var learningObjectives = [learning_Objective]()
    @Published var name : String = ""
    
    // Decide if the data can be overriden or not
    var isSavable = true
    
    // this function will remove all the evaluation to a learning objective indicated by the index
    func remove_Evaluation(index : Int ) {
        
        if isSavable {
            PersistenceController.shared.delete(l_Objective: learningObjectives[index])
        }
        
        learningObjectives[index].eval_score.removeAll()
        learningObjectives[index].eval_date.removeAll()
    }
    
    /// Will evaluate a learning objective in position index
    ///
    /// INPUT:
    ///     index : Int = rapresent the index of the learning objective in the learning objectives
    ///     evaluation : Int = rapresent the evaluation that have to be passed to the learning objective
    ///     date : Date = rapresent the date of the evaluation that hav e to be added to the learning objective
    ///
    ///  OUTPUT:
    ///         The evaluation was added to the learning objective in position index
    func evaluate_Object(index : Int, evaluation : Int, date : Date ){
        
        learningObjectives[index].eval_date.append(date)
        learningObjectives[index].eval_score.append(evaluation)
        
        if isSavable {
            PersistenceController.shared.evalutate_Learning_Objective(l_Objective: learningObjectives[index])
        }
        
        
    }
    
    func evaluate_Object(index : Int, evaluations : [Int], dates : [Date]){
        learningObjectives[index].eval_date = dates
        learningObjectives[index].eval_score = evaluations
    }
    
    func reset_Evaluated(onComplete: @escaping() -> Void){
        
        for index in 0..<learningObjectives.count {
            if(learningObjectives[index].eval_date.count > 0) {
                learningObjectives[index].eval_date = []
                learningObjectives[index].eval_score = []
            }
        }
        
        onComplete()
        
    }
    
    func load_Status(objectives: FetchedResults<EvaluatedObject>){
        
        /// core data implementation
        
        if isSavable {
            let cd_Learned_Obectives = PersistenceController().load(objectives: objectives)
            
            for evaluated_Ojectives in cd_Learned_Obectives {
                
                    let index = learningObjectives.firstIndex(where: {$0.ID == evaluated_Ojectives.id})
                
                    if index != nil {
                        learningObjectives[index!].eval_score = evaluated_Ojectives.eval_Score
                        learningObjectives[index!].eval_date = evaluated_Ojectives.eval_Date
                    }
            }
        }
        
        /// user default implementation
        
//        let data = UserDefaults.standard.object(forKey: "evaluated_Object")
//        if data != nil {
//            if let evaluated_Objects = try? PropertyListDecoder().decode([learning_Objective].self, from: data as! Data ) {
//
//                for evaluated_Object in evaluated_Objects {
//                    let index = learningObjectives.firstIndex(where: {$0.ID == evaluated_Object.ID})
//                    if index != nil {
//                        learningObjectives[index!] = evaluated_Object
//                    }
//                }
//            }
//        }
    }
    
    func load_Test_Data(_ completion: @escaping (() -> Void)) {
        
        learningObjectives = []
        
        guard let file_Path_Learning_Objective = Bundle.main.path(forResource: "Coders", ofType: "csv") else {
            return
        }
        
        guard let file_Rubric_Levels = Bundle.main.path(forResource: "ALL PATHS", ofType: "csv") else {
            return
        }
        
        var data_Learning_Objectives = ""
        var data_Rubric_Levels = ""
        
        do {
            data_Learning_Objectives = try String(contentsOfFile: file_Path_Learning_Objective)
            data_Rubric_Levels = try String(contentsOfFile: file_Rubric_Levels)
        } catch {
            print(error)
            return
        }
        
        var rows_Learning_Objectives = data_Learning_Objectives.components(separatedBy: "\n")
        var rows_Rubric_Levels = data_Rubric_Levels.components(separatedBy: "\n")
        
        rows_Learning_Objectives.removeFirst()
        rows_Learning_Objectives.removeLast()
        
        rows_Rubric_Levels.removeFirst()
        rows_Rubric_Levels.removeLast()
        
        for row_Index in 0..<rows_Learning_Objectives.count {
            
            let learning_Objective_Columned = rows_Learning_Objectives[row_Index].components(separatedBy: ";")
            
            let rubric_Levels_Columned = rows_Rubric_Levels[row_Index].components(separatedBy: ";")
            
            let learning_Objective_Element = learning_Objective(learning_Objective_Raw: learning_Objective_Columned, rubric_Level_Raw: rubric_Levels_Columned)
            
            learningObjectives.append(learning_Objective_Element)
        }
        
        completion()
    }
    
    func load_Rubric_Levels() -> [rubric_Level]{
        var csvToStruct : [rubric_Level] = []
        
        guard let filePath = Bundle.main.path(forResource: "ALL PATHS", ofType: "csv") else {
            return csvToStruct
        }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            return csvToStruct
        }
        
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst()
        rows.removeLast()
        
        for row in rows {
            
            let csvColumns = row.components(separatedBy: ";")
            
            let rubric_Level_Object = rubric_Level(new_Raw: csvColumns)
            //            let LOsStruct = rubric_Level.init(raw: csvColumns)
            csvToStruct.append(rubric_Level_Object)
            
        }
        
        return csvToStruct
    }
    
    func load_Learning_Rubric() -> [rubric_Level]{
        
        var csvToStruct : [rubric_Level] = []
        
        guard let filePath = Bundle.main.path(forResource: "Rubric_Level", ofType: "csv") else {
            return csvToStruct
        }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            return csvToStruct
        }
        
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst()
        rows.removeLast()
        
        for row in rows {
            
            let csvColumns = row.components(separatedBy: ",")
            
            let LOsStruct = rubric_Level.init(raw: csvColumns)
            csvToStruct.append(LOsStruct)
            
        }
        
        return csvToStruct
        
    }
    
}

class LearningPathStore: ObservableObject {
    @Published var learningPaths = [learning_Path]()
    
    func addItem(_ item: learning_Path) {
        learningPaths.append(item)
    }
    
    func load_Learning_Path(){
        
        guard let filePath = Bundle.main.path(forResource: "ALL PATHS", ofType: "csv") else {
            learningPaths = []
            return
        }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            learningPaths = []
            return
        }
        
        let row = data.components(separatedBy: "\n").first!
        
        let csvColumns = row.components(separatedBy: ";")
        
        learningPaths.append(learning_Path(title: "None"))
        for index in 5..<csvColumns.count {
            print("\(csvColumns[index])")
            learningPaths.append(learning_Path(title: csvColumns[index].replacingOccurrences(of: "Path", with: "").replacingOccurrences(of: "level", with: "")))
        }
    }
}

class StrandsStore: ObservableObject {
    @Published var strands = [String]()
    var arrayStrandsFilter = [FilterChoice]()
    var arrayStrandsNativeFilter = [String]()
    
    func setupStrandsOnNativeFilter(learningObjectives: [learning_Objective]) {
        for learningObjective in learningObjectives {
            if !arrayStrandsNativeFilter.contains(learningObjective.strand) {
                arrayStrandsNativeFilter.append(learningObjective.strand)
            }
        }
    }
}

class TotalNumberOfLearningObjectivesStore: ObservableObject {
    @Published var total: Int = 0
    @Published var changeViewTotal: Int = 0
    @Published var isChanged: Bool = false
}
