//
//  Services.swift
//  LJM
//
//  Created by denys pashkov on 16/12/21.
//

import Foundation

class Services{
    let Endpoint = "http://www.FuckingTony.com"
    
    func learning_Objectives_To_Server(learning_Objectives : [learning_Objective]) -> [Learning_Objective_Server] {
        var result : [Learning_Objective_Server] = []
        
        for learning_Objective in learning_Objectives {
            
            let temp_Rubric_Levels : Rubric_Levels = Rubric_Levels(
                core: learning_Objective.core_Rubric_Levels[0],
                uiux: learning_Objective.core_Rubric_Levels[1],
                frontend: learning_Objective.core_Rubric_Levels[2],
                backend: learning_Objective.core_Rubric_Levels[3],
                game_design: learning_Objective.core_Rubric_Levels[4],
                game_development: learning_Objective.core_Rubric_Levels[5],
                business: learning_Objective.core_Rubric_Levels[6],
                project: learning_Objective.core_Rubric_Levels[7]
            )
            
            let temp_Server_Learning_Objective = Learning_Objective_Server(
                id: learning_Objective.ID,
                strand: learning_Objective.strand,
                goal_short_name: learning_Objective.goal_Short,
                goal: learning_Objective.goal,
                objective: learning_Objective.description,
                keywords: learning_Objective.Keyword,
                rubric_levels: temp_Rubric_Levels
            )
            
            result.append(temp_Server_Learning_Objective)
            
        }
        
        return result
    }
    
    func server_To_Learning_Objectives(server_Learning_Objectives : [Learning_Objective_Server]) -> [learning_Objective]{
        
        var result : [learning_Objective] = []
        
        for server_Learning_Objective in server_Learning_Objectives {
            result.append(learning_Objective(server_Learning_Objective: server_Learning_Objective))
        }
        
        return result
    }
    
    func student_Server_Data_To_Client_Data(student_Server : Student_Server) -> (String,[CD_Evaluated_Object]){
        
        let student_Name = student_Server.name
        
        var evaluated_Objects : [CD_Evaluated_Object] = []
        
        for eval_Object in student_Server.learning_objective {
            var temp_Eval_Date : [Date] = []
            var temp_Eval_Score : [Int] = []
            for index in eval_Object.evaluated.indices {
                temp_Eval_Date.append(Date(timeIntervalSince1970: TimeInterval(eval_Object.evaluated[index].date_timestamp)) )
                temp_Eval_Score.append(eval_Object.evaluated[index].score)
            }
            let temp_Eval_Object = CD_Evaluated_Object(id: eval_Object.id, eval_Date: temp_Eval_Date, eval_Score: temp_Eval_Score)
            evaluated_Objects.append(temp_Eval_Object)
        }
        
        return (student_Name,evaluated_Objects)
    }
    
    func client_Data_To_Server_Student_Data(token : String, name : String, learning_Objectives : [learning_Objective]) -> Student_Server{
        
        var temp_Learning_Objectives : [Learning_Objective] = []
        
        for learning_Objective in learning_Objectives {
            
            var temp_Evaluated : [Evaluated] = []
            
            for index in learning_Objective.eval_score.indices {
                temp_Evaluated.append(Evaluated(score: learning_Objective.eval_score[index], date_timestamp: Int(learning_Objective.eval_date[index].timeIntervalSince1970)))
            }
            
            temp_Learning_Objectives.append(Learning_Objective(id: learning_Objective.ID, evaluated: temp_Evaluated))
        }
        
        let student_Server = Student_Server(name: name, timestamp: Int( Date().timeIntervalSince1970 ), tokn: "Token?", learning_objective: temp_Learning_Objectives)
        
        return student_Server
    }
}
