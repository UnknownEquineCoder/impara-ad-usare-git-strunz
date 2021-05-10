import Foundation

extension LJM.API {
    @frozen enum URLs: URL {
        case objectives = "https://ljm-dev-01.fed.it.iosda.org/api/learning-objective"
        case assessments = "https://ljm-dev-01.fed.it.iosda.org/api/assessment/history"
        case paths = "https://ljm-dev-01.fed.it.iosda.org/api/learning-path/"
    }
}
