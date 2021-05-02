import SwiftUI
import Alamofire

/**
 Skeleton for the new api
 This one is generic and requires an Enum with all types that we want to use with relative endpoind paths
 */
final class API {
    
    private init() { /* Business logic */ }
    
    // Singleton because we avoid memory retain 100%
    static var shared: API = {
        API()
    }()
    
    final func fetch<T: LJMData>(byID: T.ID, as type: T.Type = T.self) -> T {
        undefined("TO DO: IMPLEMENT FETCH")
    }
    
    final func update<T: LJMData>(fromID: T.ID, with value: T) -> T {
        undefined("TO DO: IMPLEMENT UPDATE")
    }
    
    final func fetchList<T: LJMCodableData>
    (as type: [T].Type = [T].self, completion: @escaping (Result<[T], Error>)->()) {
        AF.request(API.Routing.route(T.self)!.url, headers: Headers.headers)
            .responseDecodable(of: type) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

extension API {
    @frozen fileprivate enum Routing {
        case objectives
        case assessments(id: String)
        case paths
        
        static func route<T: LJMData>(_ type: T.Type, id: String? = nil) -> Routing? {
            switch type{
            case is LearningObjective.Type:
                return .objectives
            case is Assessment.Type:
                return .assessments(id: id ?? "Undefined ID")
            case is LearningPath.Type:
                return .paths
            default:
                return nil
            }
        }
        
        var url: URL {
            switch self {
            case .objectives:
                return API.URLs.objectives.rawValue
            case .assessments(let id):
                return API.URLs.assessments.rawValue.appendingPathComponent(id)
            case .paths:
                return API.URLs.paths.rawValue
            }
        }
    }
}

extension API {
    @frozen fileprivate enum URLs: URL {
        case objectives = "1"
        case assessments = "0"
        case paths = "2"
    }
}

extension API {
    struct Headers {
        static let headers : HTTPHeaders = [
            //            "Authorization": "Bearer "+URLs.loginKey!
        ]
        
        static let headersFull : HTTPHeaders = [
            //            "Authorization": "Bearer "+URLs.loginKey!,
            "Content-Type" : "application/json",
            "accept" : "application/json"
        ]
    }
}

