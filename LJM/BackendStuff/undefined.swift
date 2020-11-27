import Foundation

func undefined<T>(_ message: String) -> T {
    fatalError(message)
}
