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
        var csvToStruct = [learning_Objective]()
        
        guard let filePath = Bundle.main.path(forResource: "Learning_Objectives", ofType: "csv") else {
            learning_Objectives = []
            return
        }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            learning_Objectives = []
            return
        }
        
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst()
        rows.removeLast()
        
        for row in rows {
            
            let csvColumns = row.components(separatedBy: ",")
            
            let LOsStruct = learning_Objective.init(raw: csvColumns)
            csvToStruct.append(LOsStruct)
        }
        learning_Objectives = csvToStruct
    }
}

