import Alamofire

extension LJM.API {
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
