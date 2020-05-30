import Foundation

struct RepositoryOwnerResponse: Equatable {
    let name: String
    let photoUrl: URL
    
    func asModel() -> RepositoryOwnerModel {
        return RepositoryOwnerModel(name: name, photoUrl: photoUrl)
    }
}

extension RepositoryOwnerResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case photoUrl = "avatar_url"
    }
}

