import Foundation

enum ViewState<S: Equatable, E: Error & Equatable, L: Equatable>: Equatable {
    case success(S)
    case error(E)
    case loading(L)
}

enum AppError: Error, Equatable {
    case genericError
}
