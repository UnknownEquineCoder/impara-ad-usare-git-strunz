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
        learning_Objectives = csvToStruct
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

