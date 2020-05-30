import Foundation

struct RepositoriesModel: Equatable {
    let totalCount: Int
    let incompleteResults: Bool
    let repositories: [RepositoryModel]
}
