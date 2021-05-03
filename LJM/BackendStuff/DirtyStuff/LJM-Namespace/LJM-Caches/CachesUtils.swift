import Foundation

extension LJM.Caches {
    @frozen enum CacheKeys: String {
        case learningObjectives
        case learningPaths
    }
}

extension LJM.Caches {
    static func cache<T: LJMData>(_ type: T.Type) -> IndexableCache<[T]>? {
        switch type {
        case is LearningObjective.Type:
            return LJM.Caches.learningObjectives as? IndexableCache<[T]>
        case is LearningPath.Type:
            return LJM.Caches.learningPaths as? IndexableCache<[T]>
        default:
            return nil
        }
    }
    
    static func cacheKey<T: LJMData>(_ type: T.Type) -> CacheKeys.RawValue? {
        switch type {
        case is LearningObjective.Type:
            return CacheKeys.learningObjectives.rawValue
        case is LearningPath.Type:
            return CacheKeys.learningPaths.rawValue
        default:
            return nil
        }
    }
    
    static func cachedValue<T: LJMData>(_ type: T.Type) -> [T]? {
        guard let cache = LJM.Caches.cache(T.self),
              let key = LJM.Caches.cacheKey(T.self),
              let cachedValue = cache.object(forKey: key)
        else { return nil }
        
        return cachedValue
    }
    
    static func updateCache<T: LJMData>(_ type: T.Type, value: [T]) {
        LJM.Caches.cache(T.self)?
            .setObject(value, forKey: LJM.Caches.cacheKey(T.self) ?? "Wrong key")
    }
}
