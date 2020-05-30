import Moya
import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking
@testable import StarredGithub

final class RepositoriesServiceSpec: QuickSpec {
    override func spec() {
        describe("repositories service requests") {
            context("get repositories list from github API") {
                it("should return a list of repositories") {
                    let stubbingProvider = MoyaProvider<RepositoryTargetType>(stubClosure: MoyaProvider.immediatelyStub)
                    let params = RepositoriesQueryParameters(
                        query: RepositoriesQuery(language: "swift"),
                        sortType: "stars",
                        pageNumber: 1,
                        itemPerPageCount: 30
                    )
                    stubbingProvider.request(.getRepositories(parameters: params)) { result in
                        switch result {
                        case .success(let response):
                            do {
                                let responseModel = try response.map(RepositoriesResponse.self)
                                expect(responseModel) == .testRepositoriesResponse
                            } catch let error {
                                fail(error.localizedDescription)
                            }
                        case .failure:
                            fail()
                        }
                    }
                }
            }
        }
    }
}
