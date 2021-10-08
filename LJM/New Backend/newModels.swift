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
