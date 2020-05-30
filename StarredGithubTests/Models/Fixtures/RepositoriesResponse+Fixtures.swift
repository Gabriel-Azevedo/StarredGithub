@testable import StarredGithub

extension RepositoriesResponse {
    static var testRepositoriesResponse: RepositoriesResponse {
        return RepositoriesResponse(totalCount: 1, incompleteResults: false, repositories: [.testRepositoryResponse])
    }
}

extension RepositoriesModel {
    static var testRepositoriesModel: RepositoriesModel {
        return RepositoriesModel(totalCount: 1, incompleteResults: false, repositories: [.testRepositoryModel])
    }
}
