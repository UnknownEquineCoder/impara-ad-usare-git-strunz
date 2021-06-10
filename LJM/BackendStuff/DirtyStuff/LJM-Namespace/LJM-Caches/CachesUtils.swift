import Foundation

extension LJM.Caches {
    @frozen enum CacheKeys: String {
        case learningObjectives
        case learningPaths
        case assessments
    }
}

extension LJM.Caches {
    static func cache<T: LJMData>(_ type: T.Type) -> IndexableCache<[T]>? {
        switch type {
        case is LJM.Models.LearningObjective.Type:
            return LJM.Caches.learningObjectives as? IndexableCache<[T]>
        case is LJM.Models.LearningPath.Type:
            return LJM.Caches.learningPaths as? IndexableCache<[T]>
        case is LJM.Models.Assessment.Type:
            return LJM.Caches.assessments as? IndexableCache<[T]>
        default:
            return nil
        }
    }
    
    static func cacheKey<T: LJMData>(_ type: T.Type) -> CacheKeys.RawValue? {
        switch type {
        case is LJM.Models.LearningObjective.Type:
            return CacheKeys.learningObjectives.rawValue
        case is LJM.Models.LearningPath.Type:
            return CacheKeys.learningPaths.rawValue
        case is LJM.Models.Assessment.Type:
            return CacheKeys.assessments.rawValue
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
