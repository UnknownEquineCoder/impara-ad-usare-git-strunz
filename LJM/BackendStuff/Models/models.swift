import Foundation
import SwiftUI
import Combine

protocol LJMData: Identifiable {}
protocol LJMEncodableData: LJMData & Encodable {}
protocol LJMDecodableData: LJMData & Decodable {}
protocol LJMCodableData: LJMData & Codable {}

struct Mentor: LJMCodableData {
    var id: String
    var name: String
    var picture: String?
    var email: String
}

struct Student: LJMCodableData {
    var id: String
    var name: String
    var picture: String?
    var email: String
    var mentor: Mentor?
}

enum CoreEnum: String {
    case core = "Core"
    case elective = "Elective"
    case evaluated = "Evaluated"
    case all = "All"
}

enum MapEnum: String {
    case full = "FULL MAP"
    case communal = "COMMUNAL"
}

enum ChallengeEnum: String {
    case MC1 = "MC1"
}

enum Value {
    case noexposure
    case beggining
    case progressing
    case proficient
    case exemplary
}

struct LearningPath: LJMCodableData, Identifiable, Equatable {
    var id: String?
    var title: String?
    var description: String?
    var createdByStudent: String?
    var learningObjectives: [LearningObjective]?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case createdByStudent
        case learningObjectives
    }
    
    static func == (lhs: LearningPath, rhs: LearningPath) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}

struct LearningObjective: LJMCodableData, Hashable {
    
    var id: String?
    var tags : [String]?
    var code: String?
    var strand: Strand?
    var learningGoal: String?
    var isCore: Bool?
    var objective: String?
    var coreRubricLevel: Int?
    var description: String?
    var createdByLearner: String?
    var documentation: String?
    var assessments: [Assessment]?
    var learningPaths: [LearningPathReference]?
    var rubricLevels: [RubricLevels]?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tags
        case code
        case strand
        case objective
        case learningGoal
        case isCore
        case documentation
        case description
        case createdByLearner
        case coreRubricLevel
        case assessments
        case learningPaths
        case rubricLevels
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LearningObjective, rhs: LearningObjective) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
    
//    func getAssessments() -> Void {
//        if let id = id {
//            Webservices.getAssessmentHistoryOfLearningObjective(learningObjectiveId: id!) { (assessments : [Assessment]?, err) in
//                if let assessments = assessments {
//                    self.assessments = assessments
//                }
//            }
//        }
//    }
}

struct LearningPathReference: LJMCodableData, Equatable {
    var id: String?
    var title: String?
    
    static func == (lhs: LearningPathReference, rhs: LearningPathReference) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}

struct Assessment: LJMCodableData, Identifiable, Hashable {
    var id: String?
    var value: Int?
    var date: String?
    var learningObjectiveId: String?
    var learnerId: String?
    var __v: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case value
        case date
        case learningObjectiveId = "learningObjective"
        case learnerId
        case __v
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Strand: LJMCodableData, Identifiable, Equatable {
    var id: String
    var strand: String
    var color: StrandColor?
    var __v: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case strand
        case color
        case __v
    }
    
    static func == (lhs: Strand, rhs: Strand) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}

struct RubricLevels: Codable {
    var path: String?
    var value: Int?
}

struct StrandColor: Codable {
    var light: LightStrandColor
    var dark: DarkStrandColor
}

struct LightStrandColor: Codable {
    var red: Int
    var green: Int
    var blue: Int
}

struct DarkStrandColor: Codable {
    var red: Int
    var green: Int
    var blue: Int
}

struct StudentJourneyLearningObjectives: Decodable {
    var learningObjectives: [LearningObjective?]
}

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct DeleteLOFromJourneyResponse: Codable {
    var deletedCount: Int
    var ok: Int
}

class LearningPathStore: ObservableObject {
    @Published var learningPaths = [LearningPath]()
    
    func addItem(_ item: LearningPath) {
        learningPaths.append(item)
    }
}

class ChallengesStore: ObservableObject {
    @Published var challenges = [LearningPath]()
    
    func addItem(_ item: LearningPath) {
        challenges.append(item)
    }
}

class StudentLearningObjectivesStore: ObservableObject {
    @Published var learningObjectives = [LearningObjective]()
    
    func addItem(_ item: LearningObjective) {
        learningObjectives.append(item)
    }
    
    func removeItem(_ item: LearningObjective) {
        learningObjectives.remove(object: item)
    }
}

class MapLearningObjectivesStore: ObservableObject {
    @Published var learningObjectives = [LearningObjective]()
    
    func addItem(_ item: LearningObjective) {
        learningObjectives.append(item)
    }
}

class StrandsStore: ObservableObject {
    @Published var strands = [String]()
    
    func addItem(_ item: String) {
        strands.append(item)
    }
}

class TotalNumberLearningObjectives: ObservableObject {
    @Published var total: Int = 0
    @Published var changeViewTotal: Int = 0
}

class SelectedSegmentView: ObservableObject {
    @Published var selectedView: String = "Map"
}

class StrandsFilter: ObservableObject {
    @Published var strands: [String] = [String]()
}

class HistoryStore: ObservableObject {
    @Published var history: [Assessment] = [Assessment]()
}
