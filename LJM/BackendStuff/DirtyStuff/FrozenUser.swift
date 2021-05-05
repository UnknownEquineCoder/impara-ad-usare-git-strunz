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
    
    var name = "John"
    var surname = "Doe"
    
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
}
