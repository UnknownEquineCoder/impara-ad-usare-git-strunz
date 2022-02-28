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
    private let TOKEN = "AgGZQ4QvkHsAAAAAAAAAAUElilkJdjDb_Q71yuGcIQX5IJNh76YIxtgEh8uObZ6e"
    
    // Singleton pattern
    static let instance = DropboxManager()
    private init() {}
    
    /*
     Function to upload data on Dropbox once in a month
     */
    func checkForUploadUserData(_ data : Data){
        
        // constants
        let userDefaultsKey = "checkForUploadUserDataDate"
        let twoWeeksInSeconds: Double = 1//60 * 60 * 24 * 14
        let now = Date()
        
        // getting saved data from user defaults
        var date = UserDefaults.standard.object(forKey: userDefaultsKey) as? Date
        if date == nil {
            // First time user open the app => creating date
            date = now
            UserDefaults.standard.set(date, forKey: userDefaultsKey)
        }
        
        // Checking if is elapsed one month since last data upload
        let diff = date!.distance(to: now)
        if diff > twoWeeksInSeconds {
            UserDefaults.standard.set(now, forKey: userDefaultsKey)
            uploadUserData(data)
            print("Dropbox data updated!")
            return
        }
            
        // Data update not needed
        let remainingTime = Int(twoWeeksInSeconds - diff)
        print("Will update Dropbox data in \(remainingTime) seconds")
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
        
        let service = "Dropbox"
        let account = ""
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        let resultData = result as? Data
        
        if resultData != nil {
            return String(data: resultData!, encoding: .utf8)!
        }
        
        // Creating a unique id and saving it into keychain
        
        let filename = UUID().uuidString
        let dataToSave = Data(filename.utf8)
        
        let saveQuery = [
            kSecValueData: dataToSave,
            kSecAttrService: service,
            kSecAttrAccount: account,
//            kSecAttrSynchronizable: kCFBooleanTrue!,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary

        // Add data in query to keychain
        SecItemAdd(saveQuery, nil)
        return filename
        
    }
    
}


