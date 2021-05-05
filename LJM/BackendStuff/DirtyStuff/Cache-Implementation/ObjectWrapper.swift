import Foundation

final class ObjectWrapper<T> {
    let value: T
    
    init(_ value: T) {
        self.value = value
    }
}
