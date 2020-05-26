import Foundation
import RxDataSources

struct RepositoriesSection: SectionModelType, Equatable {
    typealias Item = RepositoriesRowType

    var items: [RepositoriesRowType]
    
    init(repositories: [Repository]) {
        self.items = repositories.map({ repository -> RepositoriesRowType in
            return .repositoryInformation(parameters: .init(repository: repository))
        })
    }
    
    init(repository: Repository) {
        self.items = [.repositoryInformation(parameters: .init(repository: repository))]
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
    
    init(repository: Repository) {
        self.name = repository.name
        self.authorName = repository.authorName
        self.starsCount = repository.starsCount
        self.photoUrl = repository.photoUrl
        self.descriptionText = repository.descriptionText
    }
}
