import Foundation
@testable import StarredGithub

extension RepositoryOwnerResponse {
    static var testRepositoryOwnerResponse: RepositoryOwnerResponse {
        let photoUrl = "https://avatars2.githubusercontent.com/u/484656?v=4"
        return RepositoryOwnerResponse(
            name: "GabrielAzevedo",
            photoUrl: URL(string: photoUrl)!
        )
    }
}

extension RepositoryOwnerModel {
    static var testRepositoryOwnerModel: RepositoryOwnerModel {
        let photoUrl = "https://avatars2.githubusercontent.com/u/484656?v=4"
        return RepositoryOwnerModel(
            name: "GabrielAzevedo",
            photoUrl: URL(string: photoUrl)!
        )
    }
}
