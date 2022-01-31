//
//  dropbox.swift
//  LJM
//
//  Created by Marco Tammaro on 26/01/22.
//

import Foundation
import SwiftyDropbox
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class DropboxManager {
    
    // API Access token
    private let TOKEN = "<PUT TOKEN HERE>"
    
    /*
     This function upload data on Dropbox in order to have user statistics
     @Parameter data: is the content of the file
     @Parameter filename: should be unique for each user and should not change between two different uploads
     */
    func uploadUserData(data: String, filename: String) {

        var request = URLRequest(url: URL(string: "https://content.dropboxapi.com/2/files/upload")!,timeoutInterval: Double.infinity)
        
        request.addValue("Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
        request.addValue("{\"path\": \"/\(filename).txt\",\"mode\": \"overwrite\",\"autorename\": false,\"mute\": false,\"strict_conflict\": false}", forHTTPHeaderField: "Dropbox-API-Arg")
        request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = data.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
        }

        task.resume()

    }
    
}


