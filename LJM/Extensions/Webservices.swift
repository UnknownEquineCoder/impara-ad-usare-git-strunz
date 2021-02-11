//
//  Webservices.swift
//  LJM
//
//  Created by Tony Tresgots on 11/02/2021.
//

import SwiftUI
import Alamofire

class Webservices {
    private init() {
        
    }
    
    struct URLs {
        static let baseURL = URL(string: "http://wondering-parrots.ljm")!
        // AUTH URLs
        
        // LEARNING PATH URLs
        static let getLearningPathURL = baseURL.appendingPathComponent("api/learning-path")
        static let updateLearningPathURL = baseURL.appendingPathComponent("api/learning-path")
        
        // LEARNING OBJECTIVES URLs
        
        static let getLearningObjectiveURL = baseURL.appendingPathComponent("api/learning-objective")
        
        // ASSESSMENT URLs
        
        static let getAssessmentURL = baseURL.appendingPathComponent("api/assessment")
   
    }
    
    static func getLearningPath(completion : @escaping(Result<[LearningPath], Error>) -> Void) {
        
        
        
    }
}
