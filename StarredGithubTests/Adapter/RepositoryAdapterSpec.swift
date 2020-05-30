import Moya
import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking
@testable import StarredGithub

final class RepositoryAdapterSpec: QuickSpec {
    override func spec() {
        describe("a repository table view adapter") {
            context("converts an array of Repositories into an array of sections") {
                it("should return success") {
                    let repositories: [RepositoryModel] = [.testRepositoryModel, .testRepositoryModel, .testRepositoryModel]
                    let repositoriesAdapter = RepositoriesAdapter()
                    let processedRepositoriesAdapterSections = repositoriesAdapter.generateSections(repositories: repositories)
                    let expectedRepositoriesAdapterSections: [RepositoriesSection] = [.testRepositoriesSectionWithRows]
                    expect(processedRepositoriesAdapterSections) == expectedRepositoriesAdapterSections
                }
                it("asd") {
                    let a = 2000
                    expect(a.formatted()) == "2.000"
                }
            }
        }
    }
}
