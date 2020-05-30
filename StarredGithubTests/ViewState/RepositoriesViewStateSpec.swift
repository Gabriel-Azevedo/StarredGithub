import Quick
import Nimble
@testable import StarredGithub

final class RepositoriesViewStateSpec: QuickSpec {
    override func spec() {
        describe("repository view controller's view state") {
            context("returns data for each state") {
                it("on success, returns an array of repositories") {
                    let viewState = RepositoriesViewState.success(RepositoriesViewSuccessState(repositories: []))
                    expect(viewState.repositories) == []
                }
                it("on error, returns nil") {
                    let viewState = RepositoriesViewState.error(.genericError)
                    expect(viewState.repositories).to(beNil())
                }
                it("on loading, returns nil") {
                    let viewState = RepositoriesViewState.loading(true)
                    expect(viewState.repositories).to(beNil())
                }
            }
        }
    }
}
