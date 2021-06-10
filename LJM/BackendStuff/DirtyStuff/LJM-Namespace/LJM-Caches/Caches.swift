import Foundation

extension LJM {
    final class Caches {
        static public let learningObjectives = { IndexableCache<[LJM.Models.LearningObjective]>() }()
        static public let learningPaths = { IndexableCache<[LJM.Models.LearningPath]>() }()
        static public let assessments = { IndexableCache<[LJM.Models.Assessment]>() }()
    }
}
