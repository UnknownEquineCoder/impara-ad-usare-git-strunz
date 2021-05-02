import Foundation

func undefined<T>(_ message: String, line: Int = #line, file: String = #file, function: String = #function) -> T {
    fatalError("\(message)\nfunction: \(function) on line \(line) in file \(file)")
}
