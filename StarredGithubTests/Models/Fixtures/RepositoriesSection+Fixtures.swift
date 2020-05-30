@testable import StarredGithub

extension RepositoriesSection {
    static var testRepositoriesSectionWithRows: RepositoriesSection {
        return RepositoriesSection(
            repositories: [.testRepositoryModel, .testRepositoryModel, .testRepositoryModel]
        )
    }
}
