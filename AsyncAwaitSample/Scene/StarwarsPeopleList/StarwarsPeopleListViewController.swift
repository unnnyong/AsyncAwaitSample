//
//  StarwarsPeopleListViewController.swift
//  AsyncAwaitSample
//
//  Created by Eunyeong Kim on 2022/07/21.
//

import Combine
import UIKit

final class StarwarsPeopleListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            viewModel, action: #selector(viewModel.handleRefreshControl),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl

        return refreshControl
    }()

    private let viewModel = StarwarsPeopleListViewModel()
    private var cancelBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        viewModel.viewDidLoad()
    }
}

extension StarwarsPeopleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(viewModel.people[indexPath.row].name)"

        return cell
    }
}

private extension StarwarsPeopleListViewController {
    func setupViewModel() {
        viewModel.$people
            .receive(on: DispatchQueue.main)
            .sink { [weak self] person in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
            .store(in: &cancelBag)
    }
}
