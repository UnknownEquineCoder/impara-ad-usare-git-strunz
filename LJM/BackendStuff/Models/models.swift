import Foundation
import SwiftUI
import Combine

struct Mentor: Codable {
    var _id: String
    var name: String
    var picture: String?
    var email: String
}

struct Student: Codable {
    var _id: String
    var name: String
    var picture: String?
    var email: String
    var mentor: Mentor?
}

struct LearningObjOldVersion: Identifiable {
    let id = UUID()
    var title: String
    let subtitle: String
    let core: CoreEnum
    var desc: String
    let color: Color
    let challenge: [ChallengeEnum?]
    let rating: Int?
    let ratingGoal: Int?
    //    var learningPath: LearningPath
    //    var strand: Strand
}

struct Challenge: Identifiable {
    let id = UUID()
    var title: String
    var tag: String
}

struct AssessmentOld {
    var value: Value?
    var student: Student
    var learningObj: LearningObjective
    var metadata: Metadata
}

extension AssessmentOld {
    struct Metadata {
        var date: Date
        var timeStamp: String
    }
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
    case E5 = "E5"
    case WF3 = "WF3"
}

enum Value {
    case noexposure
    case beggining
    case progressing
    case proficient
    case exemplary
}

struct LearningPath: Codable, Identifiable {
    var id: String?
    var title: String?
    var description: String?
    var createdByStudent: String?
    var learningObjectives: [LearningObjective]?
    var pathColor: ColorPath
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case createdByStudent
        case learningObjectives
        case pathColor
    }
}

struct LearningObjective: Codable, Identifiable, Hashable {
        
    var id: String?
    var tags : [String]?
    var code: String?
    var strand: String?
    var title: String?
    var isCore: Bool?
    var objective: String?
    var coreRubricLevel: Int?
    var description: String?
    var createdByLearner: String?
    var documentation: String?
    var __v: Int?
    var assessments: [Assessment]?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tags
        case code
        case strand
        case objective
        case title
        case isCore
        case documentation
        case description
        case createdByLearner
        case coreRubricLevel
        case __v
        case assessments
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)!
        code = try values.decodeIfPresent(String.self, forKey: .code)
        strand = try values.decodeIfPresent(String.self, forKey: .strand)
        objective = try values.decodeIfPresent(String.self, forKey: .objective)
        documentation = try values.decodeIfPresent(String.self, forKey: .documentation)
        coreRubricLevel = try values.decodeIfPresent(Int.self, forKey: .coreRubricLevel)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        isCore = try values.decodeIfPresent(Bool.self, forKey: .isCore)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        createdByLearner = try values.decodeIfPresent(String.self, forKey: .createdByLearner)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
        assessments = try values.decodeIfPresent([Assessment].self, forKey: .assessments)
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Assessment: Codable, Identifiable, Hashable {
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

struct ColorPath: Codable {
    var red: Double
    var green: Double
    var blue: Double
}

struct StudentJourneyLearningObjectives: Codable {
    var learningObjectives: [LearningObjective?]
}

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct ConnectAnswer: Decodable {
    var id_token: String?
    var access_token: String?
    var refresh_token: String?
    var token_type: String?
    var userinfo: UserInfo?
}

struct DefaultAnswer: Decodable {
    var detail: String?
}

class LearningPathStore: ObservableObject {
    @Published var learningPaths = [LearningPath]()
    
    func addItem(_ item: LearningPath) {
        learningPaths.append(item)
    }
}

class StudentLearningObjectivesStore: ObservableObject {
    @Published var learningObjectives = [LearningObjective]()
    
    func addItem(_ item: LearningObjective) {
        learningObjectives.append(item)
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
    @Published var selectedView: String = "My Journey"
}

class StrandsFilter: ObservableObject {
    @Published var strands: [String] = [String]()
}
