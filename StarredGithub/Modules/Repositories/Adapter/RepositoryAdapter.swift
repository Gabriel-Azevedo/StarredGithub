import Foundation

struct RepositoriesAdapter {
    
    func generateSections(repositories: [Repository]) -> [RepositoriesSection] {
        let mainSection = RepositoriesSection(repositories: repositories)
        return [mainSection]
    }
}
