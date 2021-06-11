import Foundation
 
public typealias LearningObjective = LJM.Models.LearningObjective
public typealias LearningPath = LJM.Models.LearningPath
public typealias Assessment = LJM.Models.Assessment

@frozen enum Stores {
    @Sync static var learningObjectives = LJM.Dictionary<LearningObjective>()
    @Sync static var learningPaths = LJM.Dictionary<LearningPath>()
    @Sync static var assessments = LJM.Dictionary<Assessment>()
}
