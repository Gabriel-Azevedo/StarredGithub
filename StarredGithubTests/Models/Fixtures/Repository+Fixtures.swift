@testable import StarredGithub

extension RepositoryResponse {
    static var testRepositoryResponse: RepositoryResponse {
        return RepositoryResponse(
            name: "StarredGithub",
            owner: .testRepositoryOwnerResponse,
            starsCount: 123,
            descriptionText: "A simple github app listing the most popular swift projects"
        )
    }
}

extension RepositoryModel {
    static var testRepositoryModel: RepositoryModel {
        return RepositoryModel(
            name: "StarredGithub",
            owner: .testRepositoryOwnerModel,
            starsCount: 123,
            descriptionText: "A simple github app listing the most popular swift projects"
        )
    }
}

