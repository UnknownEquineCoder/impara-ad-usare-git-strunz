//
//  singleton.swift
//  LJM
//
//  Created by denys pashkov on 05/10/21.
//

import Foundation

class singleton_Shared{
    static let shared = singleton_Shared()
    var profile_data : profile = profile()
    var learning_Objectives : [learning_Objective] = []
    
    func comunal_Data_Graph(){
        let data_To_Output : [Int] = []
    }
}

class LearningObjectivesStore: ObservableObject {
    @Published var learningObjectives = [learning_Objective]()

    func addItem(_ item: learning_Objective) {
        learningObjectives.append(item)
    }

    func removeItem(_ item: learning_Objective) {
        learningObjectives.remove(object: item)
    }
    
    func evaluate_Object(index : Int, evaluation : Int, date : Date ){
        learningObjectives[index].eval_date.append(date)
        learningObjectives[index].eval_score.append(evaluation)
    }
    
    func load_Learning_Objective(){
        var csvToStruct : [learning_Objective] = []
        let rubric_Level = load_Learning_Rubric()
        
        guard let filePath = Bundle.main.path(forResource: "Learning_Objectives", ofType: "csv") else {
            return
        }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            return
        }
        
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst()
        rows.removeLast()
        
        for row in rows {
            
            let csvColumns = row.components(separatedBy: ",")
            
            if let rubric_Specific_Level = rubric_Level.first(where: {$0.ID == csvColumns[7]}) {
                let LOsStruct = learning_Objective.init(raw: csvColumns, rubric_Levels: rubric_Specific_Level.levels)
                csvToStruct.append(LOsStruct)
            }
            
        }
        learningObjectives = csvToStruct
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
        var csvToStruct = [learning_Path]()
        
        guard let filePath = Bundle.main.path(forResource: "Learning_Paths", ofType: "csv") else {
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
        
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst()
        rows.removeLast()
        
        for row in rows {
            
            let csvColumns = row.components(separatedBy: ",")
            
            let LOsStruct = learning_Path.init(raw: csvColumns)
            csvToStruct.append(LOsStruct)
        }
        learningPaths = csvToStruct
    }
}

class StrandsStore: ObservableObject {
    @Published var strands = [String]()
    var arrayStrandsFilter = [FilterChoice]()

    func addItem(_ item: String) {
        strands.append(item)
    }
    
    func setupStrandsOnFilter(learningObjective: [learning_Objective]) {
        
        for learningObjective in learningObjective {
            arrayStrandsFilter.append(FilterChoice(descriptor: learningObjective.strand))
        }
    }
}

class TotalNumberOfLearningObjectivesStore: ObservableObject {
    @Published var total: Int = 0
    @Published var changeViewTotal: Int = 0
}


//class TotalNumberLearningObjectives: ObservableObject {
//    @Published var total: Int = 0
//}
