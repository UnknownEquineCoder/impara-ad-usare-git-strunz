import Foundation

extension LJM.API {
    @frozen enum Routing {
        case objectives
        case assessments
        case paths
        case assessment(id: Assessment.ID)
        
        static func route<T: LJMData>(_ type: TypeOrArray<T>, id: AnyHashable? = nil) -> Routing? {
            switch type {
            case .array(let value):
                switch value {
                case is [LJM.Models.LearningObjective].Type:
                    return .objectives
                case is [LJM.Models.Assessment].Type:
                    return .assessments
                case is [LJM.Models.LearningPath].Type:
                    return .paths
                default:
                    return nil
                }
                
            case .type(let value):
                switch value {
                case is LJM.Models.Assessment.Type:
                    return .assessment(id: id as? String ?? "Not found")
                default:
                    return nil
                }
            }
        }
        
        var url: URL {
            switch self {
            case .objectives:
                return LJM.API.URLs.objectives.rawValue
            case .assessments:
                return LJM.API.URLs.assessments.rawValue
            case .paths:
                return LJM.API.URLs.paths.rawValue
            case .assessment(let id):
                return LJM.API.URLs.assessments.rawValue.appendingPathComponent(id)
            }
        }
    }
}


@frozen enum TypeOrArray<T> {
    case type(value: T.Type)
    case array(value: [T].Type)
    
    init(_ value: T.Type) {
        self = .type(value: value)
    }
    
    init(_ value: [T].Type) {
        self = .array(value: value)
    }
}
