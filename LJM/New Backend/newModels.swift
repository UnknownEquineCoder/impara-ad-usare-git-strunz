//
//  newModels.swift
//  LJM
//
//  Created by denys pashkov on 04/10/21.
//

import Foundation
import SwiftUI


struct learning_Objective : Equatable, Codable {
    
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
    /** Boolean to distinguish from core and elective learning objectives */
    var isCore : Bool
    /** Array to store the keywords of each learning objectives */
    var Keyword : [String]
    /** Is the array of challenge ID in witch this lerning objective appear */
    var challengeID : [String]
    
    /** Store the score history */
    var eval_score : [Int]
    /** Date of each score history */
    var eval_date : [Date]
    
    /** UNUSED - documentation reference */
    var documentation : String
    
    /** 1..5 values for each rubric_Level_Types */
    var core_Rubric_Levels : [Int]
    /** Evaluation types */
    private var rubric_Level_Types = ["Beginning","Progressing","Proficient","Exemplary"]
    
    /**
        Function to init starting from CSV file rapresented by an array of strings
     */
    init(learning_Objective_Raw : [String]){
        
        ID = learning_Objective_Raw[1]
        strand = learning_Objective_Raw[2]
        goal = learning_Objective_Raw[3]
        goal_Short = learning_Objective_Raw[4]
        description = learning_Objective_Raw[5]
        
        Keyword = learning_Objective_Raw[6].components(separatedBy: ",")
        
        let challengesArray = learning_Objective_Raw[7].components(separatedBy: ",")
        
        challengeID = []
        
        for challengeIndex in challengesArray.indices {
            challengeID.append(challengesArray[challengeIndex].replacingOccurrences(of: " ", with: ""))
        }
        
        isCore = learning_Objective_Raw[8].isEmpty ? false : true
        
        core_Rubric_Levels = []
        
        for rubric_Level_Index in 9..<learning_Objective_Raw.count {
            let pathEvaluation = learning_Objective_Raw[rubric_Level_Index].replacingOccurrences(of: "\r", with: "")
            let pathEvaluationIndex = rubric_Level_Types.firstIndex(of: pathEvaluation) ?? -1
            core_Rubric_Levels.append(pathEvaluationIndex + 2)
        }
        
        documentation = ""
        
        eval_score = []
        eval_date = []
        
    }
    
    init(server_Learning_Objective : Learning_Objective_Server){
        ID = server_Learning_Objective.id
        strand = server_Learning_Objective.strand
        goal_Short = server_Learning_Objective.goal_short_name
        goal = server_Learning_Objective.goal
        description = server_Learning_Objective.objective
        
        Keyword = server_Learning_Objective.keywords
        
        isCore = server_Learning_Objective.rubric_levels.core > 1
        
        core_Rubric_Levels = []
        
        core_Rubric_Levels = [
            server_Learning_Objective.rubric_levels.core,
            server_Learning_Objective.rubric_levels.uiux,
            server_Learning_Objective.rubric_levels.frontend,
            server_Learning_Objective.rubric_levels.backend,
            server_Learning_Objective.rubric_levels.game_design,
            server_Learning_Objective.rubric_levels.game_development,
            server_Learning_Objective.rubric_levels.business,
            server_Learning_Objective.rubric_levels.project
        ]
        
        documentation = ""
        
        eval_score = []
        eval_date = []
        challengeID = []
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


struct Challenge {
    let name : String
    let ID : String
    let start_Date : String
    let end_Date : String
}

struct learning_ObjectiveForJSON : Equatable, Codable {
    
    /** Primary Key */
    var ID : String
    /** Category */
    var strand : String
    /** SubCategory */
    var goal_Short : String
    /** SubCategory description */
    var goal : String
    /** Boolean to distinguish from core and elective learning objectives */
    var isCore : Bool
    
    /** Store the score history */
    var eval_score : [Int]
    /** Date of each score history */
    var eval_date : [Int]
    
    init(learningObjective : learning_Objective){
        ID = learningObjective.ID
        strand = learningObjective.strand
        goal_Short = learningObjective.goal_Short
        goal = learningObjective.goal
        isCore = learningObjective.isCore
        eval_score = learningObjective.eval_score
        var temp : [Int] = []
        for elem in learningObjective.eval_date {
            temp.append(Int(elem.timeIntervalSince1970))
        }
        eval_date = temp
        
    }
}

struct learningObjectiveToSend : Equatable, Codable {
    
    /** Primary Key */
    var ID : String
    /** Category */
    var strand : String
    /** SubCategory */
    var goal_Short : String
    /** SubCategory description */
    var goal : String
    /** Boolean to distinguish from core and elective learning objectives */
    var isCore : Bool
    /** Store the score history */
    var eval_score : [Int]
    /** Date of each score history */
    var eval_date : [Date]
    
    init(learningObjective : learning_Objective){
        ID = learningObjective.ID
        strand = learningObjective.strand
        goal_Short = learningObjective.goal_Short
        goal = learningObjective.goal
        isCore = learningObjective.isCore
        eval_score = learningObjective.eval_score
        eval_date = learningObjective.eval_date
    }
    
}
