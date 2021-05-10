import SwiftUI

/**
 Property Wrapper used to automatically update a datasource from both Cache and API
 */
@propertyWrapper class AutoUpdate<T: LJMCodableData> {

    var _wrapList: [T]
    
    var wrappedValue: [T] {
        get {
            
            _wrapList = update()
            return _wrapList
        }
        
        set {
            LJM.Caches.updateCache(T.self, value: newValue)
            _wrapList = newValue
        }
    }

    init(wrappedValue: [T]) {
        self._wrapList = wrappedValue
    }
    
    /// Allows to access the underlying object when refering to an
    /// object wrapped in @AutoUpdate
    ///
    /// Example usage:
    ///
    /// @AutoUpdate var items = `[Item]()`
    ///
    /// type(of: items) => returns `[Item]`/`Array<Item>`
    ///
    /// type(of: _items) => returns `AutoUpdate<Item>` (read-only)
    ///
    /// type(of: $items) => returns `AutoUpdate<Item>` (read and write)
    
    var projectedValue: AutoUpdate<T> { self }
    
    /// Returns the cached value or fetches the updated version from the API
    /// and updates the cache.
    /// Returns an empty array if an error happened while trying to fetch from API.
    ///
    /// - Returns: Either the updated data or an empty array
    
    private func update() -> [T] {
        var value: [T] = []
        if let cachedValue = LJM.Caches.cachedValue(T.self) {
            return cachedValue
        } else {
            LJM.api.fetchList(as: [T].self) {  result in
                switch result {
                case .success(let fetchedValue):
                    LJM.Caches.updateCache(T.self, value: fetchedValue)
                    value = fetchedValue
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        return value
    }
}
