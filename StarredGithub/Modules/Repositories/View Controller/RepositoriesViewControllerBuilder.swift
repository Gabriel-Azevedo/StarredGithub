import UIKit

struct RepositoriesViewControllerBuilderParameters {
    let viewModel: RepositoriesViewModelType
}

class RepositoriesViewControllerBuilder: Builder {
    
    typealias Parameters = RepositoriesViewControllerBuilderParameters
    typealias Return = UINavigationController
    
    static func build(with parameters: Parameters) -> Return {
        let viewModel = parameters.viewModel
        let repositoriesViewController = RepositoriesViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: repositoriesViewController)
        return navigation
    }
}
