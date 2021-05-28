import Foundation
#warning("DO NOT TOUCH")
#warning("DO NOT TOUCH")
#warning("DO NOT TOUCH")
#warning("DO NOT TOUCH")
#warning("DO NOT TOUCH")
#warning("DO NOT TOUCH")
#warning("DO NOT TOUCH")
#warning("DO NOT TOUCH")
extension LJM {
    open class SyncDictionary<T: LJMCodableData>: ObservableObject {
        public typealias IDDict = [T.ID : T]
        
        @Published private(set) var data: IDDict
        
        open var rawData: [T] {
            get { data.array }
        }
        
        open func get(_ id: T.ID) -> T? {
            data = refreshed()
            return data[id]
        }
        
        open func get(_ id: T.ID, defaultValue: T) -> T {
            data = refreshed()
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
        
        public required init(_ value: IDDict = [:]) { self.data = value }
        public required init(_ value: [T] = []) { self.data = value.dict }
    }
}


extension LJM.SyncDictionary {
    private func refreshed() -> IDDict {
        if let cachedValue = LJM.Caches.cachedValue(T.self) {
            return cachedValue.dict
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
        return value.dict
    }
    
    open func refresh() {
        self.data = refreshed()
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
