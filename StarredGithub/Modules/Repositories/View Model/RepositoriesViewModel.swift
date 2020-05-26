import Foundation
import RxSwift
import RxCocoa

protocol RepositoriesViewModelType {
    var viewState: PublishSubject<RepositoriesViewState> { get }
}

class RepositoriesViewModel: RepositoriesViewModelType {
    var viewState = PublishSubject<RepositoriesViewState>()
}
