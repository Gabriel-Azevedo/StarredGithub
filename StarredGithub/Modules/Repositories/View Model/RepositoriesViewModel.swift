import RxSwift
import RxCocoa
import Foundation

protocol RepositoriesViewModelType {
    var viewState: BehaviorSubject<RepositoriesViewState> { get }
    var fetchRepositoriesWithReset: PublishSubject<Bool> { get }
    init(service: RepositoriesServiceProtocol)
}

class RepositoriesViewModel: RepositoriesViewModelType, ReactiveCompatible {
    
    var viewState = BehaviorSubject<RepositoriesViewState>(value: .loading(true))
    var fetchRepositoriesWithReset = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    private var service: RepositoriesServiceProtocol

    fileprivate var currentPage = 1
    private let sortType = "stars"
    private let language = "swift"
    private let itemPerPageCount = 30

    var repositories: [RepositoryModel] = []
    
    required init(service: RepositoriesServiceProtocol) {
        self.service = service
        configureBindings()
    }
    
    private func configureBindings() {
        fetchRepositoriesWithReset
            .bind(to: rx.fetchRepositories)
            .disposed(by: disposeBag)
    }
    
    fileprivate func resetRepositoriesQueryParameters() {
        currentPage = 1
        repositories.removeAll()
    }
    
    fileprivate func getRepositoriesQueryParameters() -> RepositoriesQueryParameters {
        return RepositoriesQueryParameters(
            query: RepositoriesQuery(language: language),
            sortType: sortType,
            pageNumber: currentPage,
            itemPerPageCount: itemPerPageCount
        )
    }

    fileprivate func fetchMostStarredRepositories(with parameters: RepositoriesQueryParameters) {
        service.getRepositories(parameters: parameters)
            .do(onError: { [weak self] error in
                guard let self = self else { return }
                self.viewState.onNext(.error(.genericError))
            })
            .bind(to: rx.handleFetchedRepositories)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleFetchedRepositories(repositories: [RepositoryModel]) {
        currentPage += 1
        self.repositories.append(contentsOf: repositories)
        viewState.onNext(.success(RepositoriesViewSuccessState(repositories: self.repositories)))
    }
}

private extension Reactive where Base: RepositoriesViewModel {
    var fetchRepositories: Binder<Bool> {
        return Binder(base) { controller, reset in
            if reset {
                controller.resetRepositoriesQueryParameters()
            }
            let parameters = controller.getRepositoriesQueryParameters()
            controller.fetchMostStarredRepositories(with: parameters)
        }
    }
    
    var handleFetchedRepositories: Binder<RepositoriesResponse> {
        return Binder(base) { controller, response in
            let repositoriesModel = response.asModel()
            controller.handleFetchedRepositories(repositories: repositoriesModel.repositories)
        }
    }
}
