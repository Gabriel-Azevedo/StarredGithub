import Foundation
import RxDataSources

struct RepositoriesSection: SectionModelType, Equatable {
    typealias Item = RepositoriesRowType

    var items: [RepositoriesRowType]
    
    init(repositories: [RepositoryModel]) {
        self.items = repositories.map({ repository -> RepositoriesRowType in
            return .repositoryInformation(parameters: .init(repository: repository))
        })
    }
}

extension RepositoriesSection {
    init(original: RepositoriesSection, items: [RepositoriesRowType]) {
        self = original
        self.items = items
    }
}

enum RepositoriesRowType: Equatable {
    case repositoryInformation(parameters: RepositoryInformationParameters)
}

struct RepositoryInformationParameters: Equatable {
    let name: String
    let authorName: String
    let starsCount: Int
    let photoUrl: URL
    let descriptionText: String
    
    init(repository: RepositoryModel) {
        self.name = repository.name
        self.authorName = repository.owner.name
        self.starsCount = repository.starsCount
        self.photoUrl = repository.owner.photoUrl
        self.descriptionText = repository.descriptionText ?? ""
    }
}
