import Foundation
import RxSwift
import RxCocoa
import Moya

protocol RepositoriesViewModelType {
    var viewState: BehaviorSubject<RepositoriesViewState> { get }
    var fetch: PublishSubject<Void> { get }
    init(service: RepositoriesServiceProtocol)
}

class RepositoriesViewModel: RepositoriesViewModelType {
    
    var viewState = BehaviorSubject<RepositoriesViewState>(value: .loading(true))
    var fetch = PublishSubject<Void>()
    private var currentPage = 1
    private let disposeBag = DisposeBag()
    private var service: RepositoriesServiceProtocol

    var repositories: [Repository] = [] {
        didSet {
            viewState.onNext(.success(RepositoriesViewSuccessState(repositories: repositories)))
        }
    }

    
    required init(service: RepositoriesServiceProtocol) {
        self.service = service
        self.configureBindings()
    }
    
    private func configureBindings() {
        fetch
            .subscribe(onNext: { _ in
                       self.fetchMostStarredRepositories()
                   })
            .disposed(by: disposeBag)
    }

    func fetchMostStarredRepositories() {
        let repositoriesQueryParameters = RepositoriesQueryParameters(
            query: RepositoriesQuery(language: "swift"),
            sortType: "stars",
            pageNumber: currentPage,
            itemPerPageCount: 5
        )
        service.getRepositories(parameters: repositoriesQueryParameters)
            .subscribe(onNext: { repositoriesList in
                self.repositories.append(contentsOf: repositoriesList.repositories)
            }, onError: { error in
//                self.viewState.onNext(.error(AppError(error: error)))
            })
            .disposed(by: disposeBag)
    }
}

struct RepositoriesQueryParameters: Codable {
    let query: RepositoriesQuery
    let sortType: String
    let pageNumber: Int
    let itemPerPageCount: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "q": query.toString(),
            "sort": sortType,
            "page": pageNumber,
            "per_page": itemPerPageCount
        ]
    }
}

struct RepositoriesQuery: Codable {
    let language: String
    
    func toString() -> String {
        return "language:\(language)"
    }
}

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

extension ObservableType where Element == Moya.Response {
    func map<T: Decodable>(_ type: T.Type) -> Observable<T> {
        return flatMap { (response : Response) -> Observable<T> in
            return Observable.just(try response.map(type))
        }
    }
}


enum RepositoryTargetType {
    case getRepositories(parameters: RepositoriesQueryParameters)
}

extension RepositoryTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getRepositories:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRepositories:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getRepositories(let parameters):
            return .requestParameters(parameters: parameters.toDictionary(), encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
