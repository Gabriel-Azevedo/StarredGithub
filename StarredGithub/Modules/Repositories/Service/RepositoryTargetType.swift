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

    var task: Task {
        switch self {
        case .getRepositories(let parameters):
            return .requestParameters(parameters: parameters.toDictionary(), encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .getRepositories:
            return """
                    {
                        \"total_count\": 1,
                        \"incomplete_results\": false,
                        \"items\": [
                            {
                                \"name\": \"StarredGithub\",
                                \"stargazers_count\": 123,
                                \"description\": \"A simple github app listing the most popular swift projects\",
                                \"owner\": {
                                    \"login\": \"GabrielAzevedo\",
                                    \"avatar_url\": \"https://avatars2.githubusercontent.com/u/484656?v=4\"
                                }
                            }
                        ]
                    }
                """
                .data(using: String.Encoding.utf8)!
        }
    }
}
