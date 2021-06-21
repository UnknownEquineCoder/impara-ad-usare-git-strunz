import Foundation
import SwiftUI

extension LJM {
    @frozen public enum Models {
        typealias Code = String
        typealias ReadableDate = String
        
        public struct LearningObjective: LJMCodableData, Hashable {
            public var id: String
            var tags : [String]?
            var learningGoal: String?
            var description: String?
            var documentation: String?
            var code: Code
            var strand: String?
            var assessments: [Models.Assessment]?
            
            func isCore(from store: [LearningPath] = Stores.learningPaths.rawData) -> Bool {
                isIn(.CORE, from: store)
            }
            
            func isIn(_ path: LearningPaths, from store: [LearningPath] = Stores.learningPaths.rawData) -> Bool {
                let corePath = store.path(with: path)
                let keys = corePath?.expectedValues.map { $0.keys.first }
                
                print("Keys: \(String(describing: keys)), len: \(keys?.count ?? 0)")
                
                return keys?.contains(self.id) ?? false
            }
            
            enum CodingKeys: String, CodingKey {
                case id = "_id"
                case tags = "tags"
                case learningGoal = "learningGoal"
                case description = "description"
                case documentation = "documentation"
                case code = "code"
                case strand = "strand"
                case assessments = "assessment"
            }
        }
        
        public struct Assessment: LJMCodableData, Hashable {
            public var id: String
            var score: Score.RawValue?
            var date: ReadableDate
            var learningObjectiveId: Models.LearningObjective.ID?
            var learnerId: String?
        }
        
        public struct LearningPath: LJMCodableData, Hashable {
            public var id: String
            var name: String
            var expectedValues: [[Code : Score]]
            
            func learningObjectives(from store: [LearningObjective] = Stores.learningObjectives.rawData) -> [LearningObjective] {
                let codes = expectedValues.map { $0.keys.first }
                return store.filter { codes.contains($0.id) }
            }
            
            enum CodingKeys: String, CodingKey {
                case id = "_id"
                case name = "title"
                case expectedValues = "expectedValues"
            }
        }
        
        
        
        @frozen public enum Score: Int, Codable, CaseIterable, Hashable {
            case JUST_ADDED = 0
            case WILLING = 1
            case BEGINNING = 2
            case PROGRESSING = 3
            case PROFICIENT = 4
            case EXEMPLARY = 5
        }
    }
}

extension Date {
    static func readable(_ date: Date = Date()) -> LJM.Models.ReadableDate {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

public enum LearningPaths: String, CaseIterable {
    case CORE = "Core"
    case UI_UX = "UI/UX"
    case BACKEND = "Backend"
    case FRONTEND = "Frontend"
    case BUSINESS = "Business"
}

@frozen public enum Strands: String, CaseIterable {
    case BUSINESS = "App Business and Marketing"
    case PROCESS = "Process"
    case PROFESSIONAL_SKILLS = "Professional Skills"
    case TECHNICAL = "Technical"
    case DESIGN = "Design"
    
    func toColor(dark: Bool) -> Color {
        switch self {
        case .BUSINESS:
            return dark ?
                Color(red: 151, green: 032, blue: 167) :
                Color(red: 143, green: 042, blue: 157)
        case .DESIGN:
            return dark ?
                Color(red: 173, green: 217, blue: 137) :
                Color(red: 173, green: 217, blue: 137)
        case .TECHNICAL:
            return dark ?
                Color(red: 114, green: 087, blue: 255) :
                Color(red: 129, green: 105, blue: 252)
        case .PROCESS:
            return dark ?
                Color(red: 252, green: 111, blue: 050) :
                Color(red: 221, green: 101, blue: 049)
        case .PROFESSIONAL_SKILLS:
            return dark ?
                Color(red: 252, green: 176, blue: 069) :
                Color(red: 221, green: 156, blue: 065)
        }
    }
}

extension Array where Element == LearningPath {
    func path(with name: LearningPaths) -> LearningPath? {
        return self.first { $0.name == name.rawValue }
    }
}

