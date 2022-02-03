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
    private let TOKEN = "sl.BBXhZnlfF_yJH8ZdWjLZRCUMt3BrWL2QAYEJbzresljQMV7X--eGeZAOT4eAH3IOA4_ljNyfjPg6h9QbxEa5wdtiX4CF82CbJH4BnKqMmVmcRh90pnsZfhEPKqZL3qo6DriEtV_C--WQ"
    
    static let instance = DropboxManager()
    private init() {}
    
    /*
     Function to upload data on Dropbox once in a month
     */
    func checkForUploadUserData(){
        
        let userDefaultsKey = "checkForUploadUserDataDate"
        
        var date = UserDefaults.standard.object(forKey: userDefaultsKey) as? Date
        if date == nil {
            date = Date()
            UserDefaults.standard.set(date, forKey: userDefaultsKey)
        }
        
        let now = Date()
        let diff = date!.distance(to: now)
        let oneMonthInSeconds: Double = 60*60*24*30
        
        if diff > oneMonthInSeconds {
            UserDefaults.standard.set(now, forKey: userDefaultsKey)
            uploadUserData()
            return
        }
            
        // Data update not needed
        let remainingTime = Int(oneMonthInSeconds - diff)
        print("Updating Dropbox data in \(remainingTime) seconds")
        return
        
    }
    
    /*
     This function upload data on Dropbox in order to have user statistics
     @Parameter data: is the content of the file
     @Parameter filename: should be unique for each user and should not change between two different uploads
     */
    private func uploadUserData() {
        
        let filename = getDataFilename()
        let data = getData()

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
    
    /*
     Function to collect the data fron the user that are going to be saved on dropbox
     */
    private func getData() -> String {
        // TODO
        return "TODO"
    }
    
    /*
     This function will generate a unique id that is going to be used as filename of the file collecting user information
     The generated filename is going to be saved into the keychain in sync with iCloud
     */
    private func getDataFilename() -> String{
        
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
            kSecAttrSynchronizable: kCFBooleanTrue!,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary

        // Add data in query to keychain
        SecItemAdd(saveQuery, nil)
        return filename
        
    }
    
}


