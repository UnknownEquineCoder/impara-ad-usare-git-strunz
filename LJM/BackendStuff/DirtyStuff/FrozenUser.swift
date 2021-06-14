import SwiftKeychainWrapper
import SwiftUI

class FrozenUser: ObservableObject {
    var loginKey: String? {
        get {
            KeychainWrapper.standard.string(forKey: "tokenAuth")
        }
        
        set {
            KeychainWrapper.standard.set(newValue ?? "", forKey: "tokenAuth")
        }
    }
    
    @Published var name: String?
    @Published var surname: String?
    
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
}
