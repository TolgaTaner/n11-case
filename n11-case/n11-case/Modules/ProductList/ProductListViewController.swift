//
//  ProductListViewController.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//
//

import UIKit.UIViewController

final class ProductListViewController: UIViewController {
    
    var presenter: ProductListViewToPresenterProtocol!
    
    private lazy var navigationView: ProductListNavigationView = {
        let navigationView: ProductListNavigationView = ProductListNavigationView()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.backgroundColor = .white
        navigationView.isHidden = true
        return navigationView
    }()
    
    private lazy var contentView: UIView = {
        let contentView: UIView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var headerView: ProductListHeaderView = {
        let headerView = ProductListHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white
        headerView.isHidden = true
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SponsoredProductsTableViewSectionCell.self, forCellReuseIdentifier: SponsoredProductsTableViewSectionCell.reuseIdentifier)
        tableView.register(ListingProductTableViewSectionCell.self, forCellReuseIdentifier: ListingProductTableViewSectionCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setupContentView()
        setupNavigationView()
        setupHeaderView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    private func setupTableView() {
        contentView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupHeaderView() {
        contentView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationView() {
        contentView.addSubview(navigationView)
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
//MARK: - ProductListPresenterToViewProtocol
extension ProductListViewController: ProductListPresenterToViewProtocol {
    
    func showProductLists() {
        navigationView.isHidden = false
        headerView.isHidden = false
        tableView.reloadData()
    }
    
    func showProductListError(errorMessage: String) {
        showAlert(title: "N11", message: errorMessage)
    }
    
    func configureAfterViewDidLoad() {
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        presenter.getProductList()
    }
    
    func configureAfterViewWillAppear() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
//MARK: - UIGestureRecognizerDelegate
extension ProductListViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        navigationController?.viewControllers.count ?? 0 > 1
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.sectionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if presenter.sectionList[section] == .listing {
            let headerView = UIView()
            headerView.backgroundColor = .separator
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if presenter.sectionList[section] == .listing {
            return 10
        }
        return .zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if presenter.sectionList[indexPath.section] == .listing {
            return UITableView.automaticDimension
        }
        return view.frame.height / 5
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter.sectionList[indexPath.section] == .sponsored {
            let cell = tableView.dequeueReusableCell(withIdentifier: SponsoredProductsTableViewSectionCell.reuseIdentifier, for: indexPath) as! SponsoredProductsTableViewSectionCell
            cell.configure(sponsoredProductList: presenter.sponsoredProductList, delegate: self)
            return cell
        }
        else if presenter.sectionList[indexPath.section] == .listing {
             let cell = tableView.dequeueReusableCell(withIdentifier: ListingProductTableViewSectionCell.reuseIdentifier, for: indexPath) as! ListingProductTableViewSectionCell
            cell.configure(with: presenter.productList, delegate: self)
             return cell
        }
        return UITableViewCell()
    }
}
//MARK: - Alertable
extension ProductListViewController: Alertable {}

//MARK: - ListingProductTableViewSectionCellDelegate
extension ProductListViewController: ListingProductTableViewSectionCellDelegate {
    func didSelect(_ product: ListedProduct) {
        presenter.didSelectProduct(product)
    }
    
    func loadMoreProducts() {
        presenter?.loadMoreProducts()
    }
}
//MARK: - SponsoredProductsTableViewSectionCellDelegate
extension ProductListViewController: SponsoredProductsTableViewSectionCellDelegate {
    func didSelect(_ product: any Product) {
        presenter.didSelectProduct(product)
    }
}
