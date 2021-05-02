import Foundation

/**
 Storage keeps track of all the data inside the App, making access straight-forward
 
 Example usage:
 
 - We try to fetch all the Learning Objectives
 - We have them saved in the cache
 - Cache is checked to be expired
 - Cache is updated from the API
 - Cache is returned
 */

final class Storage: ObservableObject {
    
    @AutoUpdate var learningObjectives: [LearningObjective] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    
    @AutoUpdate var learningPaths: [LearningPath] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    
    private init() { /* Business logic */ }
    
    // Singleton to avoid memory retain
    static var shared: Storage = { Storage() }()

    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<Storage, [T]>, with property: KeyPath<T, P>, greaterThan: P) -> [T] {
        return self[keyPath: kp].filter { $0[keyPath: property] > greaterThan }
    }
    
    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<Storage, [T]>, with property: KeyPath<T, P>, lessThan: P) -> [T] {
        return self[keyPath: kp].filter { $0[keyPath: property] < lessThan }
    }
    
    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<Storage, [T]>, with property: KeyPath<T, P>, equalTo: P) -> [T] {
        return self[keyPath: kp].filter { $0[keyPath: property] == equalTo }
    }
    
    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<Storage, [T]>, with property: KeyPath<T, P>, differentFrom: P) -> [T] {
        return self[keyPath: kp].filter { $0[keyPath: property] != differentFrom }
    }
    
    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<Storage, [T]>,
     with property: KeyPath<T, P>,
     predicate: PickledPredicate<P>)
    -> [T]
    {
        return self[keyPath: kp].filter { predicate.0 ($0[keyPath: property], predicate.1) }
    }
}

extension Storage {
    public typealias FilterPredicate<T> = (T, T) -> (Bool)
    public typealias PickledPredicate<T> = (FilterPredicate<T>, T)
}
