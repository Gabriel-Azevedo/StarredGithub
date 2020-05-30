import Foundation
import RxSwift
import RxCocoa

typealias RepositoriesViewState = ViewState<RepositoriesViewSuccessState, AppError, Bool>

extension RepositoriesViewState {
    var repositories: [RepositoryModel]? {
        switch self {
        case .success(let state):
            return state.repositories
        default:
            return nil
        }
    }
}


extension ObservableConvertibleType where Element == RepositoriesViewState {
    
    func asSections() -> Driver<[RepositoriesSection]> {
        return asObservable()
            .mapToSections()
            .asDriver(onErrorJustReturn: [])
    }
}

extension Observable where Element == RepositoriesViewState {
    func mapToSections() -> Observable<[RepositoriesSection]> {
        return self.map { viewState in
            guard let repositories = viewState.repositories else { return [] }
            let adapter = RepositoriesAdapter()
            return adapter.generateSections(repositories: repositories)
        }
    }
}

struct RepositoriesViewSuccessState: Equatable {
    var repositories: [RepositoryModel]
}
