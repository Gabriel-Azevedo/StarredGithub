import Moya
import RxSwift
import Foundation

protocol RepositoriesServiceProtocol {
    init(provider: MoyaProvider<RepositoryTargetType>)
    func getRepositories(parameters: RepositoriesQueryParameters) -> Observable<RepositoriesResponse>
}

class RepositoriesService: RepositoriesServiceProtocol {
    private let provider: MoyaProvider<RepositoryTargetType>
    
    required init(provider: MoyaProvider<RepositoryTargetType>) {
        self.provider = provider
    }

    func getRepositories(parameters: RepositoriesQueryParameters) -> Observable<RepositoriesResponse> {
        return provider.rx.request(.getRepositories(parameters: parameters))
            .map(RepositoriesResponse.self)
            .asObservable()
    }
}
