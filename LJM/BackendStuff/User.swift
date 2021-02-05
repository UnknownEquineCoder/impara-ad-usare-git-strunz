//
//  User.swift
//  LJM
//
//  Created by Laura Benetti on 02/02/21.
//

import Foundation

struct User: Codable{
    var id_token: String
    var access_token: String
    var refresh_token: String
    var token_type: String
    var user_info: UserInfo
}

struct UserInfo: Codable{
    var sub: String
    var email: String
    var preferred_user_name: String
    var name: String
}

func login(completion: @escaping (Result<User, CustomError>)->Void) {
    guard let url = URL(string: "http://127.0.0.1:4000/auth/oidc/login") else {
        completion(.failure(.invalidID))
        return
    }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(.failure(.unableToComplete))
            return
        }
        guard let data = data else {
            completion(.failure(.invalidData))
            return
        }
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            completion(.success(user))
        } catch {
            completion(.failure(.invalidData))
        }
    }
    task.resume()
}

enum CustomError: String, Error {
    
    case invalidResponse = "The response from the server was invalid."
    case invalidData = "The data received from the server was invalid."
    case invalidID = "ID was not valid."
    case unableToComplete = "Unable to complete operation."
    
}
