import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MBProgressHUD

class RepositoriesViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        return tableView
    }()

    private let viewModel: RepositoriesViewModelType
    
    private let disposeBag = DisposeBag()
    private let cellIdentifier = "RepositoryInformationTableViewCell"
    private var refreshControl = UIRefreshControl()
    private let reloadThresholdRow = 3
    
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
        configureViewController()
    }
    
    private func configureViewController() {
        configureLayout()
        configureTableView()
        configurePullToRefresh()
        configureBindings()
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Repositories"
    }
    
    private func configureTableView() {
        tableView.register(RepositoryInformationTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func configureBindings() {
        let viewState = viewModel.viewState
            .asDriver(onErrorDriveWith: .empty()).debug()
        
        let tableViewWillDisplayCell = tableView.rx.willDisplayCell
            .filterThreshold(in: tableView, reloadThresholdRow: reloadThresholdRow)
            .shouldReset(false)
            .bind(to: viewModel.fetchRepositoriesWithReset)
        
        disposeBag.insert(
            viewState.drive(rx.errorLoadingState),
            viewState.filterSuccessState()
                .asSections()
                .drive(tableView.rx.items(dataSource: dataSource)),
            viewState.asObservable()
                .mapToLoading()
                .bind(to: refreshControl.rx.isRefreshing),
            tableViewWillDisplayCell
        )
    }

    private func configurePullToRefresh() {
        refreshControl.rx.controlEvent(.valueChanged)
            .startWith(())
            .shouldReset(true)
            .bind(to: viewModel.fetchRepositoriesWithReset)
            .disposed(by: disposeBag)
        tableView.refreshControl = refreshControl
    }
}

// MARK: - Table View Methods
private extension RepositoriesViewController {
    private func cellConfiguration(dataSource: UITableViewDataSource, tableView: UITableView,
                                   indexPath: IndexPath, item: RepositoriesRowType) -> UITableViewCell {
        switch item {
        case .repositoryInformation(let parameters):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: cellIdentifier,
                for: indexPath
            )
            guard let repositoryInformationCell = cell as? RepositoryInformationTableViewCell else { return cell }
            repositoryInformationCell.configure(
                repositoryName: parameters.name,
                authorName: parameters.authorName,
                starsCount: parameters.starsCount.formatted(),
                photoUrl: parameters.photoUrl,
                descriptionText: parameters.descriptionText
            )
            return repositoryInformationCell
        }
    }
}

// MARK: - View State's States Handling
fileprivate extension RepositoriesViewController {
    func showErrorState(error: AppError) {
        let progressHud = MBProgressHUD.showAdded(to: view, animated: true)
        progressHud.label.text = error.localizedDescription
        progressHud.mode = .text
        progressHud.label.numberOfLines = .zero
        progressHud.hide(animated: true, afterDelay: 2.0)
    }

    func startLoading() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }

    func stopLoading() {
        refreshControl.endRefreshing()
        MBProgressHUD.hide(for: view, animated: true)
    }
}

// MARK: - Reactive Methods
private extension Reactive where Base: RepositoriesViewController {
    var errorLoadingState: Binder<RepositoriesViewState> {
        return Binder(base) { controller, state in
            switch state {
            case .loading:
                controller.startLoading()
            case .error(let error):
                controller.stopLoading()
                controller.showErrorState(error: error)
            case .success:
                controller.stopLoading()
            }
        }
    }
}

// MARK: - SharedSequence Helper Methods
private extension SharedSequenceConvertibleType where Element == RepositoriesViewState {
    func filterSuccessState() -> SharedSequence<SharingStrategy, RepositoriesViewState> {
        return self.filter { state -> Bool in
            switch state {
            case .success:
                return true
            case .loading, .error:
                return false
            }
        }
    }
}

// MARK: - ControlEvent Helper Methods
private extension ControlEvent where Element == WillDisplayCellEvent {
    func filterThreshold(in tableView: UITableView, reloadThresholdRow: Int) -> Observable<WillDisplayCellEvent> {
        return self.filter({ (cell, indexPath) -> Bool in
            let numberOfRows = tableView.numberOfRows(inSection: indexPath.section)
            let currentThreshold = numberOfRows > reloadThresholdRow ? numberOfRows - reloadThresholdRow : 0
            return indexPath.row == currentThreshold
        })
    }
}

// MARK: - Observable Helper Methods
private extension ObservableType where Element == RepositoriesViewState {
    func mapToLoading() -> Observable<Bool> {
        return self.map { viewState -> Bool in
            switch viewState {
            case .success, .error:
                return false
            case .loading:
                return true
            }
        }
    }
}

private extension ObservableType {
    func shouldReset(_ reset: Bool) -> Observable<Bool> {
        return self.map { _ in reset }
    }
}
