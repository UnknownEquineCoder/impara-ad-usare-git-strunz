import SwiftUI
import Alamofire

extension LJM {
    /**
     Skeleton for the new api
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
        
        final func updateList<T: LJMCodableData>
        (of type: [T].Type = [T].self, with value: [T]) {
            
        }
        
        final func fetchList<T: LJMCodableData>
        (as type: [T].Type = [T].self, completion: @escaping (Result<[T], Error>)->()) {
            
            guard let url = API.Routing.route(T.self)?.url else { return }
            
            AF.request(url, headers: Headers.headersFull)
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
}
