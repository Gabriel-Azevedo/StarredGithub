import Foundation

struct RepositoriesAdapter {
    
    func generateSections(repositories: [RepositoryModel]) -> [RepositoriesSection] {
        let mainSection = RepositoriesSection(repositories: repositories)
        return [mainSection]
    }
}
