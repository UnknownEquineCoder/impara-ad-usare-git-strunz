//
//  dropbox.swift
//  LJM
//
//  Created by Marco Tammaro on 26/01/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class DropboxManager {
    
    // API Access token
    private let TOKEN = "sl.BEaMK2i3xy65393sIvqsg8TeP0ICXHqHi7Zhy6DVuRdCY2DRYbWBG86nPsuGyHM_PW8l-Qn39xkU4lP_S9FTT4khpXH6Bo2dE9LNm5RSf-p0rnCdyBK9mVTYg2c6vXx3pwE9OXL4"
    
    // Singleton pattern
    static let instance = DropboxManager()
    private init() {}
    
    /*
     Function to upload data on Dropbox once in a month
     */
    func checkForUploadUserData(_ data : Data){
        
        let userDefaultsKey = "checkForUploadUserDataDate"
            
        UserDefaults.standard.set( Date(), forKey: userDefaultsKey)
        uploadUserData(data)
        print("Dropbox data updated!")
        return
        
    }
    
    /*
     This function upload data on Dropbox in order to have user statistics
     @Parameter data: is the content of the file
     @Parameter filename: should be unique for each user and should not change between two different uploads
     */
    private func uploadUserData(_ data : Data) {
        
        // Getting user folder name
        let folder = getUserIdentifier()
        
        // Getting filename as 20220225_131020.json
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd_HHmmss"
        let filename = dateFormatter.string(from: date)
        
        let path = "/StudentsData/\(folder)/\(filename).json"

        var request = URLRequest(url: URL(string: "https://content.dropboxapi.com/2/files/upload")!,timeoutInterval: Double.infinity)
        
        request.addValue("Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
        request.addValue("{\"path\": \"\(path)\",\"mode\": \"overwrite\",\"autorename\": false,\"mute\": false,\"strict_conflict\": false}", forHTTPHeaderField: "Dropbox-API-Arg")
        request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
        }

        task.resume()

    }
    
    /*
     This function will generate a unique id that is going to be used as filename of the file collecting user information
     The generated filename is going to be saved into the keychain in sync with iCloud
     */
    private func getUserIdentifier() -> String{
        
        // Retriving unique id from keychain
        
        let resultData = UserDefaults.standard.string(forKey: "UserID")
        
        if resultData != nil {
            return resultData!
        }
        
        // Creating a unique id and saving it into keychain
        
        let filename = UUID().uuidString
        UserDefaults.standard.set(filename, forKey: "UserID")
        return filename
        
    }
    
}


