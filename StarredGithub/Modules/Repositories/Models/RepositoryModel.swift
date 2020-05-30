import Foundation

struct RepositoryModel: Equatable {
    let name: String
    let owner: RepositoryOwnerModel
    let starsCount: Int
    let descriptionText: String?
}
