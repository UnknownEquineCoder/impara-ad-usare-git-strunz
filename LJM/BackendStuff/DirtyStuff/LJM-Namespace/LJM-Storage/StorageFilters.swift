import Foundation

extension LJM.Storage {
    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<LJM.Storage, [T]>, with property: KeyPath<T, P>, greaterThan: P) -> [T] {
        return self[keyPath: kp].filter { $0[keyPath: property] > greaterThan }
    }
    
    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<LJM.Storage, [T]>, with property: KeyPath<T, P>, lessThan: P) -> [T] {
        return self[keyPath: kp].filter { $0[keyPath: property] < lessThan }
    }
    
    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<LJM.Storage, [T]>, with property: KeyPath<T, P>, equalTo: P) -> [T] {
        return self[keyPath: kp].filter { $0[keyPath: property] == equalTo }
    }
    
    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<LJM.Storage, [T]>, with property: KeyPath<T, P>, differentFrom: P) -> [T] {
        return self[keyPath: kp].filter { $0[keyPath: property] != differentFrom }
    }
    
    func filter<T: LJMCodableData, P: Comparable>
    (_ kp: KeyPath<LJM.Storage, [T]>,
     with property: KeyPath<T, P>,
     predicate: PickledPredicate<P>)
    -> [T]
    {
        return self[keyPath: kp].filter { predicate.0 ($0[keyPath: property], predicate.1) }
    }
}
