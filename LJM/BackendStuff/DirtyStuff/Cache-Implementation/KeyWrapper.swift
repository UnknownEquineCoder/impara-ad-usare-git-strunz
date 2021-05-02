import Foundation

final class KeyWrapper<T: Hashable>: NSObject {
    let key: T
    
    init(_ key: T) {
        self.key = key
    }
    
    override var hash: Int {
        return key.hashValue
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? KeyWrapper<T> else {
            return false
        }
        return key == other.key
    }
}
