import Alamofire

extension LJM.API {
    struct Headers {
        static let headers : HTTPHeaders = [
            "Authorization": "Bearer " + (LJM.storage.user.loginKey ?? "")
        ]
        
        static let headersFull : HTTPHeaders = [
            "Authorization": "Bearer " + (LJM.storage.user.loginKey ?? ""),
            "Content-Type" : "application/json",
            "accept" : "application/json"
        ]
    }
}
