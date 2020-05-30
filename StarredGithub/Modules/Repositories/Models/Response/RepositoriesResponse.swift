import Foundation

struct RepositoriesResponse: Equatable {
    let totalCount: Int
    let incompleteResults: Bool
    let repositories: [RepositoryResponse]
    
    func asModel() -> RepositoriesModel {
        return RepositoriesModel(
            totalCount: totalCount,
            incompleteResults: incompleteResults,
            repositories: repositories.map { $0.asModel() }
        )
    }
}

extension RepositoriesResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case repositories = "items"
    }
}

