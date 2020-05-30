import Quick
import Nimble
@testable import StarredGithub

final class RepositorySpec: QuickSpec {
    override func spec() {
        describe("a repositories list response object transformation") {
            context("convert a response object to a model") {
                it("converts successfully") {
                    let repositoriesResponse: RepositoriesResponse = .testRepositoriesResponse
                    let expectedRepositoriesModel: RepositoriesModel = .testRepositoriesModel
                    let processedRepositoriesModel = repositoriesResponse.asModel()
                    expect(processedRepositoriesModel) == expectedRepositoriesModel
                }
            }
        }
    }
}
