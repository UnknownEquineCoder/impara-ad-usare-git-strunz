import Foundation

extension LJM.API {
    @frozen enum Routing {
        case objectives
        case assessments(id: String)
        case paths
        
        static func route<T: LJMData>(_ type: T.Type, id: String? = nil) -> Routing? {
            switch type{
            case is LearningObjective.Type:
                return .objectives
            case is Assessment.Type:
                return .assessments(id: id ?? "Undefined ID")
            case is LearningPath.Type:
                return .paths
            default:
                return nil
            }
        }
        
        var url: URL {
            switch self {
            case .objectives:
                return LJM.API.URLs.objectives.rawValue
            case .assessments(let id):
                return LJM.API.URLs.assessments.rawValue.appendingPathComponent(id)
            case .paths:
                return LJM.API.URLs.paths.rawValue
            }
        }
    }
}
