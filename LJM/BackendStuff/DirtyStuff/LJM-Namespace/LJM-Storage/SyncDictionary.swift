import Foundation

@propertyWrapper
open class Sync<T: LJMCodableData> {
    
    public typealias Wrapped = LJM.Dictionary<T>
    
    private var _wrap: Wrapped
    
    open var wrappedValue: Wrapped {
        get {
            _wrap = refreshed()
            return _wrap
        }
        
        set {
            _wrap = newValue
        }
    }
    
    public init(wrappedValue: Wrapped) {
        self._wrap = wrappedValue
    }
    
    private func refreshed() -> LJM.Dictionary<T> {
        if let cachedValue = LJM.Caches.cachedValue(T.self) {
            return Wrapped(cachedValue.dict)
        }
        
        var value = [T]()
        
        LJM.api.fetchList(as: [T].self) { result in
            switch result {
            case .success(let fetchedValue):
                LJM.Caches.updateCache(T.self, value: fetchedValue)
                value = fetchedValue
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return Wrapped(value.dict)
    }
}

extension LJM {
    open class Dictionary<T: LJMCodableData>: ObservableObject {
        public typealias IDDict = [T.ID : T]
        
        @Published private(set) var data: IDDict
        
        open var rawData: [T] {
            get { data.array }
        }
        
        open func get(_ id: T.ID) -> T? {
            return data[id]
        }
        
        open func get(_ id: T.ID, defaultValue: T) -> T {
            return data[id] ?? defaultValue
        }
        
        open func update(_ value: T) {
            data[value.id] = value
            LJM.api.update(fromID: value.id, with: value)
            LJM.Caches.updateCache(T.self, value: data.array)
        }
        
        open subscript(_ id: T.ID, defaultValue: T) -> T {
            get { data[id] ?? defaultValue }
            set { update(newValue) }
        }
        
        public required init() { self.data = [:] }
        public required init(_ value: IDDict = [:]) { self.data = value }
        public required init(_ value: [T] = []) { self.data = value.dict }
    }
}


extension Array where Element: Identifiable {
    var dict: [Element.ID: Element] {
        
        var result = [Element.ID: Element]()
        
        for val in self {
            result[val.id] = val
        }
        
        return result
    }
}

extension Dictionary {
    var array: [Value] {
        [Value](self.values)
    }
}


struct Example {
    @Sync var learningObjectives = LJM.Dictionary<LJM.Models.LearningObjective>()
    
    func examples() {
        let objectivesAsArray: [LJM.Models.LearningObjective] = learningObjectives.rawData
        let objectivesAsDictionary: [String : LJM.Models.LearningObjective] = learningObjectives.data
        
        debugPrint(objectivesAsArray, objectivesAsDictionary)
    }
}

extension Optional where Wrapped: BinaryInteger {
    var orZero: Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return 0
        }
    }
}
