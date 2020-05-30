import Moya
import Foundation

enum RepositoryTargetType {
    case getRepositories(parameters: RepositoriesQueryParameters)
}

extension RepositoryTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getRepositories:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRepositories:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getRepositories(let parameters):
            return .requestParameters(parameters: parameters.toDictionary(), encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
