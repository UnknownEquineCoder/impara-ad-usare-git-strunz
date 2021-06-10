import Foundation

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
            var strand: Models.Strand?
            var assessments: [Models.Assessment]?
            
            func isCore(from store: [LearningPath] = []) -> Bool {
                isIn(.CORE, from: store)
            }
            
            func isIn(_ path: LearningPaths, from store: [LearningPath] = []) -> Bool {
                let corePath = store.path(with: path)
                let keys = corePath?.expectedValues.map { $0.keys.first }
                
                print("Keys: \(String(describing: keys)), len: \(keys?.count ?? 0)")

                return keys?.contains(self.id) ?? false
            }
        }
        
        public struct Strand: LJMCodableData, Hashable {
            public var id: String
            var name: String
        }
        
        public struct Assessment: LJMCodableData, Hashable {
            public var id: String
            var score: Score?
            var date: ReadableDate
            var learningObjectiveId: Models.LearningObjective.ID?
            var learnerId: String?
        }
        
        public struct LearningPath: LJMCodableData, Hashable {
            public var id: String
            var name: String
            var expectedValues: [[Code : Score]]
            
            func learningObjectives(from store: [LearningObjective] = []) -> [LearningObjective] {
                let codes = expectedValues.map { $0.keys.first }
                return store.filter { codes.contains($0.id) }
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

public enum LearningPaths: String {
    case CORE = "core"
    case UI_UX = "UI/UX"
    case BACKEND = "backend"
    case FRONTEND = "frontend"
    case BUSINESS = "business"
}

extension Array where Element == LearningPath {
    func path(with name: LearningPaths) -> LearningPath? {
        return self.first { $0.name == name.rawValue }
    }
}

public typealias LearningObjective = LJM.Models.LearningObjective
public typealias LearningPath = LJM.Models.LearningPath
public typealias Assessment = LJM.Models.Assessment
public typealias Strand = LJM.Models.Strand
