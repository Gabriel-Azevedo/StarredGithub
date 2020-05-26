import Foundation

struct RepositoriesViewControllerBuilderParameters {
    let viewModel: RepositoriesViewModelType
}

class RepositoriesViewControllerBuilder: Builder {
    
    typealias Parameters = RepositoriesViewControllerBuilderParameters
    typealias Return = RepositoriesViewController
    
    static func build(with parameters: Parameters) -> Return {
        let viewModel = parameters.viewModel
        return RepositoriesViewController(viewModel: viewModel)
    }
}
