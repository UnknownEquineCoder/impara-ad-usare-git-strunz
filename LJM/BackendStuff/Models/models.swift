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

struct LearningPath: Identifiable {
    let id = UUID()
    var category: PathCategory
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

