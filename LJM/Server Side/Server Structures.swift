//
//  Server Structures.swift
//  LJM
//
//  Created by denys pashkov on 16/12/21.
//

import Foundation

// MARK: - Students
struct Student_Server: Codable {
    let name: String
    let timestamp: Int
    let tokn: String
    let learning_objective: [Learning_Objective]
}

// MARK: - LearningObjective
struct Learning_Objective: Codable {
    let id: String
    let evaluated: [Evaluated]
}

// MARK: - Evaluated
struct Evaluated: Codable {
    let score: Int
    let date_timestamp: Int
}

// MARK: - LearningObjective
struct Learning_Objective_Server: Codable {
    let id, strand, goal_short_name, goal: String
    let objective: String
    let keywords: [String]
    let rubric_levels: Rubric_Levels
}

// MARK: - RubricLevels
struct Rubric_Levels: Codable {
    let core, uiux, frontend, backend: Int
    let game_design, game_development, business, project: Int
}
