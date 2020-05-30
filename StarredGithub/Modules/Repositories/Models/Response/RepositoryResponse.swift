import Foundation

struct RepositoryResponse: Equatable {
    let name: String
    let owner: RepositoryOwnerResponse
    let starsCount: Int
    let descriptionText: String?

    func asModel() -> RepositoryModel {
        return RepositoryModel(
            name: name,
            owner: owner.asModel(),
            starsCount: starsCount,
            descriptionText: descriptionText
        )
    }
}

extension RepositoryResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case owner = "owner"
        case starsCount = "stargazers_count"
        case descriptionText = "description"
    }
}
