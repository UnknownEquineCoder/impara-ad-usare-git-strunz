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

class AirTableManager {
    private let TOKEN = "keyN55muBclzvZXAb"
    private let sendHere = "https://api.airtable.com/v0/app26CHrOG4n8za36/LJM"
    
    func sendData(){
        let url = URL(string: sendHere)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "application/json")
        request.httpMethod = "POST"
    }
}

class AirtableManager {
    
    // API Access token
//    private let TOKEN = "sl.BEaMK2i3xy65393sIvqsg8TeP0ICXHqHi7Zhy6DVuRdCY2DRYbWBG86nPsuGyHM_PW8l-Qn39xkU4lP_S9FTT4khpXH6Bo2dE9LNm5RSf-p0rnCdyBK9mVTYg2c6vXx3pwE9OXL4"
    
    // Singleton pattern
    static let instance = AirtableManager()
    private init() {}
    // Real Airtable token
//    private let TOKEN = "keyN55muBclzvZXAb"
    // Old Premium Airtable token
    private let TOKEN = "keyatGjTlu9gc4VpK"

    // Test Airtable endpoint
    private let sendHere = "https://api.airtable.com/v0/app26CHrOG4n8za36/LJM"
    // Unknown Airtable endpoint
    //private let sendHere = "https://api.airtable.com/v0/applg11alQPTDJYOV/LJM"
    
    // Real Airtable endpoint
//    private let sendHere = "https://api.airtable.com/v0/app26CHrOG4n8za36/LJM"

    /*
     Function to upload data on Dropbox once in a month
     */
    func checkForUploadUserData(_ data : Data) {
        
        let userDefaultsKey = "checkForUploadUserDataDate"
            
        UserDefaults.standard.set( Date(), forKey: userDefaultsKey)
        uploadUserData(data)
        
        print("Airtable data updated!")
        return
        
    }
    
    /*
     This function upload data on Dropbox in order to have user statistics
     @Parameter data: is the content of the file
     @Parameter filename: should be unique for each user and should not change between two different uploads
     */
    private func uploadUserData(_ data : Data) {
        
        let userDefaultsKey = "checkForUploadUserData7"
        
        do{
            var request = URLRequest(url: URL(string: sendHere)!,timeoutInterval: Double.infinity)
            
            request.addValue("Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpMethod = "POST"
            let newStruct = Welcome(records: [Record(fields: Fields(id: getUserIdentifier(), data: String(bytes: data, encoding: .utf8)!))])
            let encoder = JSONEncoder()
            let result = try encoder.encode(newStruct)
            request.httpBody = result
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
              guard let data = data else {
                return
              }
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        UserDefaults.standard.set(Date(), forKey: userDefaultsKey)
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now()+40) {
                            self.uploadUserData(data)
                        }
                    }
                }
            }
            task.resume()
            
        } catch {
            print("oh no")
        }
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

// MARK: - Welcome
struct Welcome: Codable {
    let records: [Record]
}

// MARK: - Record
struct Record: Codable {
    let fields: Fields
}

// MARK: - Fields
struct Fields: Codable {
    let id, data: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case data
    }
}
