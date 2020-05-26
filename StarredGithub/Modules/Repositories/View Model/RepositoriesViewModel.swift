import Foundation
import RxSwift
import RxCocoa

protocol RepositoriesViewModelType {
    var viewState: BehaviorSubject<RepositoriesViewState> { get }
    func trigger()
}

class RepositoriesViewModel: RepositoriesViewModelType {
    var viewState = BehaviorSubject<RepositoriesViewState>(value: .loading(true))
    
    func trigger() {
        if let url = URL(string: "https://stackoverflow.com/questions/50020345/behaviorsubject-vs-publishsubject") {
        viewState.onNext(.success(RepositoriesViewSuccessState(repositories: [
            Repository(name: "repo name", authorName: "author name", starsCount: 20, photoUrl: url, descriptionText: "asdajsdjasidjpajdpiasdasdasdasdasdasdaasdajsdjasidjpajdpiasdasdasdasdasdasdaasdajsdjasidjpajdpiasdasdasdasdasdasdaasdajsdjasidjpajdpiasdasdasdasdasdasdaasdajsdjasidjpajdpiasdasdasdasdasdasdaasdajsdjasidjpajdpiasdasdasdasdasdasdaasdajsdjasidjpajdpiasdasdasdasdasdasdaasdajsdjasidjpajdpiasdasdasdasdasdasda"),
            Repository(name: "repo name2 ", authorName: "author name2", starsCount: 202, photoUrl: url, descriptionText: "asdajsdjasidjpajdpiasdasdasdasdasdasda"),
            Repository(name: "repo name3", authorName: "author name3", starsCount: 203, photoUrl: url, descriptionText: "asdajsdjasidjpajdpiasdasdasdasdasdasdaasdajsdjasidjpajdpiasdasdasdasdasdasdaasdajsdjasidjpajdpiasdasdasdasdasdasda")
        ])))
        }
    }
}
