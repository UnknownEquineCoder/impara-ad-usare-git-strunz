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
        static let baseURL = URL(string: "http://localhost")!
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
        
        let loginKey = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkpSY080bnhzNWpnYzhZZE43STJoTE80Vl9xbDFiZG9pTVhtY1lnSG00SHMifQ.eyJqdGkiOiI1YlptRmxCcXpEZWVROH55eDNYd3giLCJzdWIiOiIxMjMxODM4MDIiLCJpc3MiOiJodHRwczovL3dvbmRlcmluZy1wYXJyb3RzLWRldi5vbmVsb2dpbi5jb20vb2lkYy8yIiwiaWF0IjoxNjEzMTA2MzMzLCJleHAiOjE2MTMxMDk5MzMsInNjb3BlIjoib3BlbmlkIiwiYXVkIjoiOGY5MjAwNDAtNDY5Yi0wMTM5LTI3MTgtMGE3YzAyMjQ3NzA5MTg0MTA2In0.bNNjB_QpMf0aRBpbFR7Xl6ZgCdmB6lesCy4GrG0jdd9To-I2PGAyZUcdn0mqXhhX37k_znD4kH3N_iWeZBMKK-4zf7YjZOcNYKCRb8_YpLrU_uHd1JvrdH234bhqs0No2dn_MJcGBxKMtqVHjXSCWropRCud8zbT9eRHoXtC-Ly2ZUzCb6O6MqqjtHsdAYD8-AM4Ix_O2d1-Qhshi1vX0gTL8KOWeKmLs9NoBYLb_aTTkiE11dOjIjDSnn4_bbWLadCwQ4uFWZjEaH-IApmYA8BZpA1KoHbtdqmOuUUzQ2GfP3bjHpc9AdJVkb7Y_pITLNclmBXsFUNFepDXDh_ggQ"
        
        let headers : HTTPHeaders = [
            "Authorization": "Bearer "+loginKey
                ]
        
        AF.request(URLs.getLearningPathURL, headers: headers).responseDecodable(of: [LearningPath].self) { response in
            guard let learningPaths = response.value else {
                print("BUHNJ?K \(response) ----- \(response.result) ----- \(response.response) ------ \(response.request)  -------- \(response.value) ------- \(response.data) ------ \(response.error) ----- ")
                return
            }

            completion(.success(learningPaths))
        }
    }
}
