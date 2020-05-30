import Quick
import Nimble
@testable import StarredGithub

final class RepositoryResponseSpec: QuickSpec {
    override func spec() {
        describe("a repository response object transformation") {
            context("convert a response object to a model") {
                it("converts successfully") {
                    let repositoryResponse: RepositoryResponse = .testRepositoryResponse
                    let expectedRepositoryModel: RepositoryModel = .testRepositoryModel
                    let processedRepositoryModel = repositoryResponse.asModel()
                    expect(processedRepositoryModel) == expectedRepositoryModel
                }
            }
        }
    }
}
