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

struct Assessment {
    var value: Value?
    var student: Student
    var learningObj: LearningObjective
    var metadata: Metadata
}

extension Assessment {
    struct Metadata {
        var date: Date
        var timeStamp: String
    }
}

enum CoreEnum: String {
    case core = "Core"
    case elective = "Elective"
    case evaluated = "Evaluated"
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

enum PathCategory {
    case design
    case frontend
    case backend
    case business
    case game
}

enum Strand {
    case professional
    case design
    case business
    case technical
    case process
}

struct LearningPath: Codable, Identifiable {
    var id: String?
    var title: String?
    var description: String?
    var createdByStudent: String?
    var learningObjectives: [LearningObjective?]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case createdByStudent
        case learningObjectives
    }
}

struct LearningPathIdAnswer: Codable {
    var title: String?
    var description: String?
    var createdByLearner: String?
    var learningObjectives: [String?]
}

struct LearningObjective: Codable, Identifiable, Hashable {
    var id: String?
    var tags : [String?]
    var title: String?
    var isCore: Bool?
    var isElective: Bool?
    var description: String?
    var createdByLearner: String?
    var __v: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tags
        case title
        case isCore
        case isElective
        case description
        case createdByLearner
        case __v
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
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

struct UserInfos: Decodable {
    var sub: String?
    var email: String?
    var preferred_username: String?
    var name: String?
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
