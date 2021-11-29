//
//  newModels.swift
//  LJM
//
//  Created by denys pashkov on 04/10/21.
//

import Foundation
import SwiftUI


struct learning_Objective : Equatable, Encodable, Decodable {
    
    /** Primary Key */
    var ID : String
    /** Category */
    var strand : String
    /** SubCategory */
    var goal_Short : String
    /** SubCategory description */
    var goal : String
    /** Description */
    var description : String
    var isCore : Bool
    var Keyword : [String]
    
    /** Score history */
    var eval_score : [Int]
    /** Date of score history */
    var eval_date : [Date]
    
    /** UNUSED - documentation reference */
    var documentation : String
    
    /** 1..5 values for each rubric_Level_Types */
    var core_Rubric_Levels : [Int]
    /** Evaluation types */
    private var rubric_Level_Types = ["Beginning","Progressing","Proficient","Exemplary"]
    
    /**
        Function to init the learning_Objective starting from CSV file
     */
    init(learning_Objective_Raw : [String]){
        
        ID = learning_Objective_Raw[0]
        strand = learning_Objective_Raw[1]
        goal_Short = learning_Objective_Raw[2]
        goal = learning_Objective_Raw[3]
        description = learning_Objective_Raw[4]
        
        if(learning_Objective_Raw[5].isEmpty){
            Keyword = learning_Objective_Raw[6].components(separatedBy: ",")
        } else {
            Keyword = learning_Objective_Raw[5].components(separatedBy: ",")
        }
        
        isCore = learning_Objective_Raw[7].isEmpty ? false : true
        
        core_Rubric_Levels = []
        
        for rubric_Level_Index in 7..<learning_Objective_Raw.count {
            let pathEvaluation = learning_Objective_Raw[rubric_Level_Index].replacingOccurrences(of: "\r", with: "")
            let pathEvaluationIndex = rubric_Level_Types.firstIndex(of: pathEvaluation) ?? -1
            core_Rubric_Levels.append(pathEvaluationIndex + 2)
        }
        
        documentation = ""
        
        eval_score = []
        eval_date = []
    }
}

/**
 Core Data Evaluated Object
 */
struct CD_Evaluated_Object : Equatable {
    /** Primary key */
    let id : String
    /** Date of score history */
    var eval_Date : [Date]
    /** Score history */
    var eval_Score : [Int]
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

enum CoreEnum: String {
    case core = "Core"
    case elective = "Elective"
    case evaluated = "Evaluated"
    case all = "All"
    case nothing = "nil"
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
