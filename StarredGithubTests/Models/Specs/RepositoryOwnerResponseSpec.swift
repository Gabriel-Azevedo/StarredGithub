import Quick
import Nimble
@testable import StarredGithub

final class RepositoryOwnerResponseSpec: QuickSpec {
    override func spec() {
        describe("a repository owner response object transformation") {
            context("convert a response object to a model") {
                it("converts successfully") {
                    let repositoryOwnerResponse: RepositoryOwnerResponse = .testRepositoryOwnerResponse
                    let expectedRepositoryOwnerModel: RepositoryOwnerModel = .testRepositoryOwnerModel
                    let processedRepositoryOwnerModel = repositoryOwnerResponse.asModel()
                    expect(processedRepositoryOwnerModel) == expectedRepositoryOwnerModel
                }
            }
        }
    }
}
