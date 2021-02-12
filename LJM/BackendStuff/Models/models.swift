import Foundation
import SwiftUI

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

struct LearningObj: Identifiable {
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

struct LearningPath: Decodable {
    var _id: String?
    var title: String?
    var description: String?
    var createdByStudent: String?
    var learningObjectives: [LearningObjective?]
    
    enum CodingKeys: String, CodingKey {
      case _id
      case title
      case description
      case createdByStudent
      case learningObjectives = "learningObjectives"
    }
}



struct Challenge: Identifiable {
    let id = UUID()
    var title: String
    var tag: String
}

struct Assessment {
    var value: Value?
    var student: Student
    var learningObj: LearningObj
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

struct Tag: Codable {
    var tags: String?
}

struct LearningObjective: Codable {
    var _id: String?
    var tags : [Tag?]
    var title: String?
    var isCore: Bool?
    var isElective: Bool?
    var description: String?
    var createdByLearner: String?
    var __v: Int?
    
    enum CodingKeys: String, CodingKey {
      case _id
      case tags
      case title
      case isCore
      case isElective
      case description
      case createdByLearner
      case __v
    }
}
