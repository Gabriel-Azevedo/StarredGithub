import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RepositoriesViewController: UIViewController {

    private let tableView: UITableView = {
        return UITableView()
    }()

    private let viewModel: RepositoriesViewModelType
    
    private let disposeBag = DisposeBag()

    private lazy var dataSource = RxTableViewSectionedReloadDataSource<RepositoriesSection>(
        configureCell: { [weak self] dataSource, tableView, indexPath, item in
            guard let self = self else { return UITableViewCell() }
            return self.cellConfiguration(
                dataSource: dataSource,
                tableView: tableView,
                indexPath: indexPath,
                item: item
            )
        }
    )

    init(viewModel: RepositoriesViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
    }
    
    
    private func configureBindings() {
        let viewState = viewModel.viewState
            .asDriver(onErrorDriveWith: .empty())
        
        disposeBag.insert(
            viewState.drive(rx.errorLoadingState),
            viewState.asSections()
                .drive(tableView.rx.items(dataSource: dataSource))
        )
    }
}

// MARK: - Table View Methods
extension RepositoriesViewController {
    private func cellConfiguration(dataSource: UITableViewDataSource, tableView: UITableView,
                                   indexPath: IndexPath, item: RepositoriesRowType) -> UITableViewCell {
        switch item {
        case .repositoryInformation(let parameters):
            return UITableViewCell()
        }
    }
}

// MARK: - View State's States Handling
extension RepositoriesViewController {
    fileprivate func showErrorState() {
    }
    
    fileprivate func hideErrorState() { }
    
    fileprivate func startLoading() {
//        MBProgressHUD.showAdded(to: view, animated: true)
    }

    fileprivate func stopLoading() {
//        MBProgressHUD.hide(for: view, animated: true)
    }
}

// MARK: - Reactive Methods
extension Reactive where Base: RepositoriesViewController {
    var errorLoadingState: Binder<RepositoriesViewState> {
        return Binder(base) { controller, state in
            switch state {
            case .loading:
                controller.startLoading()
            case .error:
                controller.showErrorState()
                controller.stopLoading()
            case .success:
                controller.hideErrorState()
                controller.stopLoading()
            }
        }
    }
}
