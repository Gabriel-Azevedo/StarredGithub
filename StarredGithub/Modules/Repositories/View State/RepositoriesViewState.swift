import Foundation
import RxSwift
import RxCocoa

typealias RepositoriesViewState = ViewState<RepositoriesViewSuccessState, NSError, Bool>

extension RepositoriesViewState {
    var repositories: [Repository]? {
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
        return asObservable().map { viewState in
            guard let state = viewState.repositories else { return [] }
            let adapter = RepositoriesAdapter()
            return adapter.generateSections(repositories: state)
        }
        .asDriver(onErrorJustReturn: [])
    }
}

struct RepositoriesViewSuccessState: Equatable {
    var repositories: [Repository]
}
