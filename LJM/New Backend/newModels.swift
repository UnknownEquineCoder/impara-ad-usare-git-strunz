//
//  newModels.swift
//  LJM
//
//  Created by denys pashkov on 04/10/21.
//

import Foundation
import SwiftUI

struct learning_Objective : Equatable {
    
    var ID : String
    var strand : String
    var goal : String
    var goal_Short : String
    var description : String
    var isCore : Bool
    var Keyword : [String]
    var core_Rubric_Levels : [Int]
    var documentation : String
    
    var eval_score : [Int]
    var eval_date : [Date]
    
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
    
    init(new_Raw : [String]){
        ID = new_Raw[0]
        strand = new_Raw[1]
        goal = new_Raw[2]
        goal_Short = new_Raw[3]
        description = new_Raw[4]
        
        if(new_Raw[5].isEmpty){
            Keyword = new_Raw[5].components(separatedBy: ",")
        } else {
            Keyword = new_Raw[6].components(separatedBy: ",")
        }
        
        isCore = new_Raw[7].isEmpty ? false : true
        
        core_Rubric_Levels = [isCore ? 2 : 0,1,3,4,5,0]
        documentation = ""
        
        eval_score = []
        eval_date = []
    }
}

struct learning_Path {
    var title : String
    var learning_Objective_IDs : [String]
   
    init(raw : [String]){
        title = raw[0]
        learning_Objective_IDs = raw[1].components(separatedBy: "-")
    }
}

struct rubric_Level {
    var ID : String
    var levels : [Int]
//    var core_Level : Int
//    var UI_UX_Level : Int
//    var front_Level : Int
//    var back_Level : Int
//    var game_Level : Int
//    var business_Level : Int
    
    init(raw : [String]){
        ID = raw[0]
        levels = [] 
        for index in 1...raw.count-1 {
            levels.append(Int(raw[index]) ?? 0)
        }
    }
}

struct profile {
    var ID : String = "nice_ID"
    var name : String = "peppe peppardi"
    var image : Image?
    var evaluated_Objective_IDs : [String] = []
}

struct evaluated_Objective {
    var learning_Objective_ID : String
    var score : [Int]
    var date : [Date]
}

struct challenge {
    
}

enum CoreEnum: String {
    case core = "Core"
    case elective = "Elective"
    case evaluated = "Evaluated"
    case all = "All"
}

enum MapEnum: String {
    case full = "FULL MAP"
    case communal = "COMMUNAL"
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
