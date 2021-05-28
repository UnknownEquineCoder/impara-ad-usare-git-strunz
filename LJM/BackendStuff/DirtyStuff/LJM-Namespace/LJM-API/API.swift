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
        
        final func fetch<T: LJMData>(byID: AnyHashable, as type: T.Type = T.self) -> T {
            undefined("TO DO: IMPLEMENT FETCH")
        }
        
        final func update<T: LJMCodableData>(fromID: AnyHashable, with value: T) {
            
            guard let url = API.Routing.route(.type(value: T.self), id: fromID)?.url else { return }
            
            print("URL", url)
            
            guard let params = value.dictionary else { return }
            
            print("Params", params)
            
            AF.request(url, method: .post, parameters: params, headers: Headers.headersFull).validate(statusCode: 200 ..< 299).responseJSON {
                response in
                
                print("Response", response)
                
                let decoder = JSONDecoder()
                
                do {
                    switch response.result {
                    case .success:
                        print("success",response)
                        let json = try decoder.decode(T.self, from: response.data!)
                        print(json)
                    case .failure(let error):
                        print("failure",error)
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        final func updateList<T: LJMCodableData>
        (of type: [T].Type = [T].self, with value: [T]) {
            
        }
        
        final func fetchList<T: LJMCodableData>
        (as type: [T].Type = [T].self, completion: @escaping (Result<[T], Error>)->()) {
            
            guard let url = API.Routing.route(.array(value: type.self))?.url else { return }
            
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

extension Encodable {
  var dictionary: Parameters? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? Parameters }
  }
}
