import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RepositoriesViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
//        view.insertSubview(indicator, at: .zero)
        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        return indicator
    }()

    private let viewModel: RepositoriesViewModelType
    
    private let disposeBag = DisposeBag()
    private let cellIdentifier = "RepositoryInformationTableViewCell"
    private var refreshControl = UIRefreshControl()

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
            .asDriver(onErrorDriveWith: .empty())
        
        disposeBag.insert(
            viewState.drive(rx.errorLoadingState),
            viewState.asSections()
                .drive(tableView.rx.items(dataSource: dataSource)),
            viewState.asObservable()
                .mapToLoading()
                .bind(to: refreshControl.rx.isRefreshing)
        )
    }
    
    private func configurePullToRefresh() {
        refreshControl.rx.controlEvent(.valueChanged).startWith(())
            .bind(to: viewModel.fetch)
            .disposed(by: disposeBag)
        tableView.refreshControl = refreshControl
        tableView.rx.willDisplayCell
            .subscribe(onNext: { (cell, indexPath) in
                if indexPath.row == self.tableView.numberOfRows(inSection: indexPath.section) - 1 {
                    self.viewModel.fetch.onNext(())
                }
            })
            .disposed(by: disposeBag)
    }
}

extension Observable where Element == RepositoriesViewState {
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

// MARK: - Table View Methods
extension RepositoriesViewController {
    private func cellConfiguration(dataSource: UITableViewDataSource, tableView: UITableView,
                                   indexPath: IndexPath, item: RepositoriesRowType) -> UITableViewCell {
        switch item {
        case .repositoryInformation(let parameters):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellIdentifier,
                for: indexPath
                ) as? RepositoryInformationTableViewCell else { return UITableViewCell() }
            cell.configure(
                repositoryName: parameters.name,
                authorName: parameters.authorName,
                starsCount: "\(parameters.starsCount)",
                photoUrl: parameters.photoUrl,
                descriptionText: parameters.descriptionText
            )
            return cell
        }
    }
}

// MARK: - View State's States Handling
extension RepositoriesViewController {
    fileprivate func showErrorState() {
    }
    
    fileprivate func hideErrorState() { }
    
    fileprivate func startLoading() {
        loadingIndicator.startAnimating()
//        tableView.isHidden = true
    }

    fileprivate func stopLoading() {
        loadingIndicator.stopAnimating()
//        tableView.isHidden = false
        refreshControl.endRefreshing()
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
