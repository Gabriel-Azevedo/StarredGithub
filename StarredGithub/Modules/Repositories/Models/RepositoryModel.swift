import Foundation

struct RepositoriesResponse: Equatable, Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let repositories: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case repositories = "items"
    }
}

struct Repository: Equatable, Codable {
    let name: String
    let owner: RepositoryOwner
    let starsCount: Int
    let descriptionText: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case owner = "owner"
        case starsCount = "stargazers_count"
        case descriptionText = "description"
    }
}

struct RepositoryOwner: Equatable, Codable {
    let name: String
    let photoUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case photoUrl = "avatar_url"
    }
}
