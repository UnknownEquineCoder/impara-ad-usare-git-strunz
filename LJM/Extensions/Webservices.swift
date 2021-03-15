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
    
    typealias ArrayLearningPathWebserviceResponse = ([LearningPath], APIError?) -> Void
    typealias LearningPathWebserviceResponse = (LearningPath, APIError?) -> Void
    typealias ArrayLearningObjectiveWebserviceResponse = ([LearningObjective], APIError?) -> Void
    typealias LearningObjectiveWebserviceResponse = (LearningObjective, APIError?) -> Void
    typealias AssessmentWebserviceResponse = (Assessment, APIError?) -> Void
    
    struct Headers {
        static let headers : HTTPHeaders = [
            "Authorization": "Bearer "+URLs.loginKey
        ]
    }
    
    struct URLs {
        static let loginKey = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkpSY080bnhzNWpnYzhZZE43STJoTE80Vl9xbDFiZG9pTVhtY1lnSG00SHMifQ.eyJqdGkiOiJLNjk4YnM2XzViOTBBWDJpcmRUV28iLCJzdWIiOiIxMjMxODM4MDIiLCJpc3MiOiJodHRwczovL3dvbmRlcmluZy1wYXJyb3RzLWRldi5vbmVsb2dpbi5jb20vb2lkYy8yIiwiaWF0IjoxNjE1Nzc5OTA0LCJleHAiOjE2MTU3OTQzMDQsInNjb3BlIjoib3BlbmlkIiwiYXVkIjoiOGY5MjAwNDAtNDY5Yi0wMTM5LTI3MTgtMGE3YzAyMjQ3NzA5MTg0MTA2In0.Tnat243e0YmPyzJxv_tKjP-L5u2hAJI9cSK5i1-EqTdUpdIitXVITkiku1h46yQXkUiAp7ULeR2ICM3iz1-KkxO6bC1UED7CHiRcJMe1DuvR7AvPaUmY2XVjd6TelZh3NMB3tkGBTviuiYhmQPoqpM6hB0MpZMVmCy1KbLVKxIZOtUvckt4hevkUeSlLbmM2MBXFzFr-G8KqmVezLVsyuFBcadAlQxJ87pScJZMni7Nr6BZKo50LgN474jmFd5HJtH9ZyXlThEB6agP9z-Fi2fdSKHFD5BSqRthpqVl6OKZLdPfEhO4izs6_8YfVXTJkmlnXW2NO2rv2_Oai4suRiw"
        static let baseURL = URL(string: "http://localhost")!
        // AUTH URLs
        static let loginURL = baseURL.appendingPathComponent("/api/auth/oidc/login")
        
        // LEARNING PATH URLs
        static let getLearningPathsURL = baseURL.appendingPathComponent("api/learning-path")
        static let getLearningPathURL = baseURL.appendingPathComponent("api/learning-path")
        static let updateLearningPathURL = baseURL.appendingPathComponent("api/learning-path")
        
        // LEARNING OBJECTIVES URLs
        
        static let getLearningObjectiveURL = baseURL.appendingPathComponent("api/learning-objective")
        static let getStudentJourneyLearningObjectiveURL = baseURL.appendingPathComponent("api/learning-objective/journey")
        
        
        // ASSESSMENT URLs
        
        static let getAssessmentURL = baseURL.appendingPathComponent("api/assessment")
        
    }
    
    
    static func getAllLearningPaths(completion : @escaping ArrayLearningPathWebserviceResponse) {
        
        AF.request(URLs.getLearningPathsURL, headers: Headers.headers).responseDecodable(of: [LearningPath].self){ response in
            
            print("IJNUHYG \(response)")
            
            guard let learningPaths = response.value else {
                return
            }
            
            completion(learningPaths, nil)
        }
    }
    
    static func getLearningPath(id: String, completion : @escaping LearningPathWebserviceResponse) {
        
        AF.request(URLs.getLearningPathURL.appendingPathComponent(id), headers: Headers.headers).responseDecodable(of: LearningPath.self) { response in
            
            guard let learningPath = response.value else {
                return
            }
            
            completion(learningPath, nil)
        }
    }
    
    static func getStudentJourneyLearningObjectives(completion : @escaping ArrayLearningObjectiveWebserviceResponse) {
        
        AF.request(URLs.getStudentJourneyLearningObjectiveURL, headers: Headers.headers).responseDecodable(of: [LearningObjective].self) { response in
            guard let learningObjectives = response.value else {
                return
            }
            
            completion(learningObjectives, nil)
        }
    }
    
    
    
    //    static func addLearningPath(title: String, description: String, learningObjectives: [String?], createdByLearner: String, completion : @escaping LearningPathIdWebserviceResponse) {
    //
    //        let headers : HTTPHeaders = [
    //            "Authorization": "Bearer "+URLs.loginKey,
    //            "Content-Type" : "application/json",
    //            "accept" : "application/json"
    //        ]
    //
    //        let params : Parameters = ["title": title, "description": description, "learningObjectives": learningObjectives, "createdByLearner": createdByLearner]
    //
    //        AF.request(URLs.updateLearningPathURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
    //            let decoder = JSONDecoder()
    //
    //            do {
    //                switch response.result {
    //                case .success:
    //                    print("success",response)
    //                    let json = try decoder.decode(LearningPathIdAnswer.self, from: response.data!)
    //                    completion(json, nil)
    //                case .failure(let error):
    //                    print("failure",error)
    //                }
    //            } catch {
    //                print(error)
    //            }
    //        }
    //    }
    
    //    static func updateLearningPath(id: String, title: String?, description: String?, learningObjectives: [String?], createdByLearner: String?, completion : @escaping LearningPathIdWebserviceResponse) {
    //
    //        let headers : HTTPHeaders = [
    //            "Authorization": "Bearer "+URLs.loginKey,
    //            "Content-Type" : "application/json",
    //            "accept" : "application/json"
    //        ]
    //
    //        let params : Parameters = [
    //            "id" : id,
    //            "title": title,
    //            "description": description,
    //            "learningObjectives": learningObjectives,
    //            "createdByLearner": createdByLearner]
    //
    //        AF.request(URLs.updateLearningPathURL.appendingPathComponent(id), method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
    //            let decoder = JSONDecoder()
    //
    //            do {
    //                switch response.result {
    //                case .success:
    //                    print("success",response)
    //                    let json = try decoder.decode(LearningPathIdAnswer.self, from: response.data!)
    //                    completion(json, nil)
    //                case .failure(let error):
    //                    print("failure",error)
    //                }
    //            } catch {
    //                print(error)
    //            }
    //        }
    //    }
    
    //    static func deleteLearningPath(id: String, completion : @escaping LearningPathIdWebserviceResponse) {
    //
    //        let headers : HTTPHeaders = [
    //            "Authorization": "Bearer "+URLs.loginKey,
    //            "Content-Type" : "application/json",
    //            "accept" : "application/json"
    //        ]
    //
    //        let params : Parameters = [
    //            "id" : id
    //        ]
    //
    //        AF.request(URLs.updateLearningPathURL.appendingPathComponent(id), method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
    //            let decoder = JSONDecoder()
    //
    //            do {
    //                switch response.result {
    //                case .success:
    //                    print("success",response)
    //                    let json = try decoder.decode(LearningPathIdAnswer.self, from: response.data!)
    //                    completion(json, nil)
    //                case .failure(let error):
    //                    print("failure",error)
    //                }
    //            } catch {
    //                print(error)
    //            }
    //        }
    //    }
    
    static func getAllLearningObjectives(completion : @escaping ArrayLearningObjectiveWebserviceResponse) {
        
        AF.request(URLs.getLearningObjectiveURL, headers: Headers.headers).responseDecodable(of: [LearningObjective].self) { response in
            
            guard let learningObjectives = response.value else {
                return
            }
            
            completion(learningObjectives, nil)
        }
    }
    
    static func getLearningObjective(id: String, completion : @escaping LearningObjectiveWebserviceResponse) {
        
        AF.request(URLs.getLearningObjectiveURL.appendingPathComponent(id), headers: Headers.headers).responseDecodable(of: LearningObjective.self) { response in
            
            guard let learningObjective = response.value else {
                return
            }
            
            completion(learningObjective, nil)
        }
    }
    
    static func addLearningObjective(learningObjective: LearningObjective, completion : @escaping LearningObjectiveWebserviceResponse) {
        
        //        let headers : HTTPHeaders = [
        //            "Authorization": "Bearer "+URLs.loginKey,
        //            "Content-Type" : "application/json",
        //            "accept" : "application/json"
        //        ]
        
        let params : Parameters = [
            "title": learningObjective.title,
            "isCore": learningObjective.isCore,
            "description": learningObjective.description,
            "tags": learningObjective.tags,
            "createdByLearner": learningObjective.createdByLearner
        ]
        
        AF.request(URLs.getLearningObjectiveURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Headers.headers).validate().responseJSON { (response) in
            let decoder = JSONDecoder()
            
            do {
                switch response.result {
                case .success:
                    print("success",response)
                    let json = try decoder.decode(LearningObjective.self, from: response.data!)
                    completion(json, nil)
                case .failure(let error):
                    print("failure",error)
                }
            } catch {
                print(error)
            }
        }
    }
    
    static func updateLearningObjective(learningObjective: LearningObjective, completion : @escaping LearningObjectiveWebserviceResponse) {
        
        //        let headers : HTTPHeaders = [
        //            "Authorization": "Bearer "+URLs.loginKey,
        //            "Content-Type" : "application/json",
        //            "accept" : "application/json"
        //        ]
        
        let params : Parameters = [
            "id" : learningObjective.id,
            "assessments" : learningObjective.assessments
        ]
        
        AF.request(URLs.getLearningObjectiveURL.appendingPathComponent(learningObjective.id!), method: .put, parameters: params, encoding: JSONEncoding.default, headers: Headers.headers).validate().responseJSON { (response) in
            let decoder = JSONDecoder()
            
            do {
                switch response.result {
                case .success:
                    print("success",response)
                    let json = try decoder.decode(LearningObjective.self, from: response.data!)
                    completion(json, nil)
                case .failure(let error):
                    print("failure",error)
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    static func deleteLearningObjective(learningObjective: LearningObjective, completion : @escaping LearningObjectiveWebserviceResponse) {
        
        //        let headers : HTTPHeaders = [
        //            "Authorization": "Bearer "+URLs.loginKey,
        //            "Content-Type" : "application/json",
        //            "accept" : "application/json"
        //        ]
        
        let params : Parameters = [
            "id" : learningObjective.id
        ]
        
        AF.request(URLs.getLearningObjectiveURL.appendingPathComponent(learningObjective.id!), method: .delete, parameters: params, encoding: JSONEncoding.default, headers: Headers.headers).validate().responseJSON { (response) in
            let decoder = JSONDecoder()
            
            do {
                switch response.result {
                case .success:
                    print("success",response)
                    let json = try decoder.decode(LearningObjective.self, from: response.data!)
                    completion(json, nil)
                case .failure(let error):
                    print("failure",error)
                }
            } catch {
                print(error)
            }
        }
    }
    
    static func addAssessment(learningObjId: String, date: String, value: Int, completion : @escaping AssessmentWebserviceResponse) {
        
        let headers : HTTPHeaders = [
            "Authorization": "Bearer "+URLs.loginKey,
            "Content-Type" : "application/json",
            "accept" : "application/json"
        ]
        
        let params : Parameters = [
            "value" : value,
            "date" : date,
            "learningObjective" : learningObjId
        ]
        
        AF.request(URLs.getAssessmentURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
            let decoder = JSONDecoder()
            
            do {
                switch response.result {
                case .success:
                    print("success",response)
                    let json = try decoder.decode(Assessment.self, from: response.data!)
                    completion(json, nil)
                case .failure(let error):
                    print("failure",error)
                }
            } catch {
                print(error)
            }
        }
    }
    
    static func deleteAssessment(id: String, completion : @escaping AssessmentWebserviceResponse) {

        let headers : HTTPHeaders = [
            "Authorization": "Bearer "+URLs.loginKey,
            "Content-Type" : "application/json",
            "accept" : "application/json"
        ]

        let params : Parameters = [
            "id" : id
        ]

        AF.request(URLs.getAssessmentURL.appendingPathComponent(id), method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
            let decoder = JSONDecoder()

            do {
                switch response.result {
                case .success:
                    print("success",response)
                    let json = try decoder.decode(Assessment.self, from: response.data!)
                    completion(json, nil)
                case .failure(let error):
                    print("failure",error)
                }
            } catch {
                print(error)
            }
        }
    }
}




// The storage containing your access token, preferable a Keychain wrapper.
//protocol AccessTokenStorage: class {
//    typealias JWT = String
//    var accessToken: JWT { get set }
//}
//
//final class RequestInterceptor: Alamofire.RequestInterceptor {
//
//    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void
//
//    private let storage: AccessTokenStorage
//
//    init(storage: AccessTokenStorage) {
//        self.storage = storage
//    }
//
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        guard urlRequest.url?.absoluteString.hasPrefix("https://api.authenticated.com") == true else {
//            /// If the request does not require authentication, we can directly return it as unmodified.
//            return completion(.success(urlRequest))
//        }
//        var urlRequest = urlRequest
//
//        /// Set the Authorization header value using the access token.
//        urlRequest.setValue("Bearer " + storage.accessToken, forHTTPHeaderField: "Authorization")
//
//        completion(.success(urlRequest))
//    }
//
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
//            /// The request did not fail due to a 401 Unauthorized response.
//            /// Return the original error and don't retry the request.
//            return completion(.doNotRetryWithError(error))
//        }
//
//        refreshToken { [weak self] success, accessToken, refreshToken in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let token):
//                self.storage.accessToken = token
//                /// After updating the token we can safely retry the original request.
//                completion(.retry)
//            case .failure(let error):
//                completion(.doNotRetryWithError(error))
//            }
//        }
//    }
//
//    private func refreshToken(completion: @escaping RefreshCompletion) {
//        let parameters = ["token": "refresh Token ici" ?? ""]
//    }
//}
