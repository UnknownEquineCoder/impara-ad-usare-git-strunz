//
//  newModels.swift
//  LJM
//
//  Created by denys pashkov on 04/10/21.
//

import Foundation
import SwiftUI

struct learning_Objective : Equatable, Encodable, Decodable {
    
    var ID : String                 // Primary Key
    var strand : String             // Category
    var goal_Short : String         // SubCategory
    var goal : String               // SubCategory description
    var description : String        // Description
    var isCore : Bool               //
    var Keyword : [String]          //
    
    var eval_score : [Int]          // Score history
    var eval_date : [Date]          // Date of score history
    
    var documentation : String      // UNUSED - documentation reference
    
    var core_Rubric_Levels : [Int]  // 1..5 values for each rubric_Level_Types
    private var rubric_Level_Types = ["Beginning","Progressing","Proficient","Exemplary"]   // Evaluation types
    
    init(raw : [String], rubric_Levels : [Int]){
        
        
        ID = raw[0]
        strand = raw[1]
        goal = raw[2]
        goal_Short = raw[3]
        description = raw[4]
        isCore = raw[5] == "true" ? true : false
        Keyword = raw[6].components(separatedBy: "-")
        core_Rubric_Levels = rubric_Levels
        documentation = raw[8]
        
        eval_score = []
        eval_date = []
    }
    
    init(learning_Objective_Raw : [String], rubric_Level_Raw : [String]){
        
        ID = learning_Objective_Raw[0]
        strand = learning_Objective_Raw[1]
        goal = learning_Objective_Raw[2]
        goal_Short = learning_Objective_Raw[3]
        description = learning_Objective_Raw[4]
        
        if(learning_Objective_Raw[5].isEmpty){
            Keyword = learning_Objective_Raw[6].components(separatedBy: ",")
        } else {
            Keyword = learning_Objective_Raw[5].components(separatedBy: ",")
        }
        
        isCore = rubric_Level_Raw[4].isEmpty ? false : true
        
        core_Rubric_Levels = [0,0,0,0,0,0]
        
        for rubric_Level_Index in 4..<rubric_Level_Raw.count {
            core_Rubric_Levels[rubric_Level_Index-4] = (rubric_Level_Types.firstIndex(of: rubric_Level_Index == 9 ? String(rubric_Level_Raw[rubric_Level_Index].dropLast()) : rubric_Level_Raw[rubric_Level_Index]) ?? -1) + 2
        }
        
        documentation = ""
        
        eval_score = []
        eval_date = []
    }
}

struct CD_Evaluated_Object : Equatable{
    let id : String
    let eval_Date : [Date]
    let eval_Score : [Int]
}

struct learning_Path: Hashable {
    var title : String
   
    init(raw : [String]){
        title = raw[0]
    }
    
    init(title : String){
        self.title = title
    }
}

struct rubric_Level {
    var ID : String
    var levels : [Int]
    
    init(raw : [String]){
        ID = raw[0]
        levels = [] 
        for index in 1...raw.count-1 {
            levels.append(Int(raw[index]) ?? 0)
        }
    }
    
    init(new_Raw : [String]){
        ID = new_Raw[0]
        levels = []
        for index in 1...new_Raw.count-1 {
            levels.append(Int(new_Raw[index]) ?? 0)
        }
    }
}

struct profile {
    var name : String = "Name Surname"
    var image : Image?
}

enum CoreEnum: String {
    case core = "Core"
    case elective = "Elective"
    case evaluated = "Evaluated"
    case all = "All"
}

enum EvaluatedOrNotEnum {
    case evaluated
    case notEvaluated
    case all
}

enum SortEnum: String {
    case first_Assest = "First assested"
    case last_Assest = "Last assested"
    case mostEvalFirst = "Most Evaluated First"
    case leastEvalFirst = "Least Evaluated First"
}

enum MapEnum: String {
    case full = "ALL"
    case communal = "CORE"
}

enum ChallengeEnum: String {
    case MC1 = "MC1"
}

enum CompassEnum: String {
    case all = "All"
    case core = "Core"
    case elective = "Elective"
    case added = "Added"
    case notAdded = "Not Added"
}
