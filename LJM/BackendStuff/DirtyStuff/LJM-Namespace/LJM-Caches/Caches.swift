import Foundation

extension LJM {
    final class Caches {
        static public let learningObjectives = { IndexableCache<[LearningObjective]>() }()
        static public let learningPaths = { IndexableCache<[LearningPath]>() }()
    }
}
