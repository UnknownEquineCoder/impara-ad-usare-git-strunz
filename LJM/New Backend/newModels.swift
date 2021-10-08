//
//  newModels.swift
//  LJM
//
//  Created by denys pashkov on 04/10/21.
//

import Foundation
import SwiftUI

struct learning_Objective {
    var ID : String
    var strand : String
    var goal : String
    var goal_Short : String
    var description : String
    var isCore : Bool
    var Keyword : [String]
    var core_Rubric_Level : [String]
    var documentation : String
}

struct learning_Path {
    var title : String
    var learning_Objective_IDs : [String]
}

struct rubric_Level {
    var ID : String
    var value : String
}

struct profile {
    var ID : String = "nice_ID"
    var name : String = "peppe peppardi"
    var image : Image?
    var evaluated_Objective_IDs : [String] = []
}

struct evaluated_Objective {
    var learning_Objective_ID : String
    var score : Int
    var date : Date
}

struct challenge {
    
}

// Sample and test CSV parsing

struct sample_learning_objective {
    var id : String?
    var strand : String?
    var goal : String?
    var goal_short : String?
    var objective : String?
    var coreKeywords : String?
    var electiveKeywords : String?
    var coreRubricLevel : String?
    var documentation : String?
    
    init(raw: [String]) {
        id = raw[0]
        strand = raw[1]
        goal = raw[2]
        goal_short = raw[3]
        objective = raw[4]
        coreKeywords = raw[5]
        electiveKeywords = raw[6]
        coreRubricLevel = raw[7]
        documentation = raw[8]
    }
}

func loadCSV(from csvName: String) -> [sample_learning_objective] {
    var csvToStruct = [sample_learning_objective]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return []
    }
    
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error)
        return []
    }
    
    var rows = data.components(separatedBy: "\n")
    
    rows.removeFirst()
    rows.removeLast()
    
    //print("@@@@@@@@@@ \(rows.last?.components(separatedBy: ",")[5])")
    
    for row in rows {
        
        let csvColumns = row.components(separatedBy: ",")
        
        let LOsStruct = sample_learning_objective.init(raw: csvColumns)
        csvToStruct.append(LOsStruct)
        
    }
    
    return csvToStruct
}
