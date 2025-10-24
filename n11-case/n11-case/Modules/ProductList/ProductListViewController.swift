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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView: UIView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var scrollViewContentView: UIView = {
        let contentView: UIView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var sponsoredCollectionViewContentView: UIView = {
        let contentView: UIView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var sponsoredCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SponsoredProductCollectionViewCell.self, forCellWithReuseIdentifier: SponsoredProductCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    private lazy var sponsoredProductsPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .separator
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private lazy var headerView: ProductListHeaderView = {
        let headerView = ProductListHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white
        headerView.isHidden = true
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setupContentView()
        setupNavigationView()
        setupScrollView()
        setupSponsoredCollectionViewContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
        presenter.viewDidLayoutSubviews()
        guard presenter.sponsoredProductList.count > 0 else { return }

          if sponsoredCollectionView.contentOffset == .zero {
              let middleIndex = IndexPath(item: presenter.sponsoredProductList.count, section: 0)
              sponsoredCollectionView.scrollToItem(at: middleIndex, at: .centeredHorizontally, animated: false)
          }
      }
    
    private func setupSponsoredCollectionViewContent() {
        scrollViewContentView.addSubview(sponsoredCollectionViewContentView)
        NSLayoutConstraint.activate([
            sponsoredCollectionViewContentView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor),
            sponsoredCollectionViewContentView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor),
            sponsoredCollectionViewContentView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor),
            sponsoredCollectionViewContentView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 5)
        ])
        
        sponsoredCollectionViewContentView.addSubview(sponsoredCollectionView)
        NSLayoutConstraint.activate([
            sponsoredCollectionView.topAnchor.constraint(equalTo: sponsoredCollectionViewContentView.topAnchor),
            sponsoredCollectionView.leadingAnchor.constraint(equalTo: sponsoredCollectionViewContentView.leadingAnchor),
            sponsoredCollectionView.trailingAnchor.constraint(equalTo: sponsoredCollectionViewContentView.trailingAnchor),
            sponsoredCollectionView.bottomAnchor.constraint(equalTo: sponsoredCollectionViewContentView.bottomAnchor)
        ])
        
        sponsoredCollectionViewContentView.addSubview(sponsoredProductsPageControl)
        NSLayoutConstraint.activate([
            sponsoredProductsPageControl.centerXAnchor.constraint(equalTo: sponsoredCollectionViewContentView.centerXAnchor),
            sponsoredProductsPageControl.bottomAnchor.constraint(equalTo: sponsoredCollectionViewContentView.bottomAnchor),
            sponsoredProductsPageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
        sponsoredCollectionViewContentView.bringSubviewToFront(sponsoredProductsPageControl)
        sponsoredCollectionViewContentView.clipsToBounds = false
    }
    
    private func setupScrollView() {
        contentView.addSubview(scrollView)
        contentView.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ])
        
        scrollView.addSubview(scrollViewContentView)
        
        NSLayoutConstraint.activate([
            scrollViewContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContentView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        let heightConstraint = scrollViewContentView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
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
    func setInfinityScroll(toPoint point: CGPoint) {
        sponsoredCollectionView.setContentOffset(point, animated: false)
    }
    
    func setPageControlPageNumber(_ number: Int) {
        sponsoredProductsPageControl.currentPage = number
    }
    
    func showProductLists() {
        sponsoredProductsPageControl.numberOfPages = presenter.sponsoredProductList.count
        navigationView.isHidden = false
        headerView.isHidden = false
        sponsoredCollectionView.reloadData()
    }
    
    func showProductListError(errorMessage: String) {
        showAlert(title: "N11", message: errorMessage)
    }
    
    func configureAfterViewDidLoad() {
        view.backgroundColor = .white
        presenter.getProductList()
    }
    
    func configureAfterViewWillAppear() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension ProductListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sponsoredCollectionView {
            return presenter.infinitySponsoredProductListItemCount
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sponsoredCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SponsoredProductCollectionViewCell.reuseIdentifier, for: indexPath) as? SponsoredProductCollectionViewCell {
                let realIndex = indexPath.item % presenter.sponsoredProductList.count
                let product = presenter.sponsoredProductList[realIndex]
                cell.configure(with: product)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sponsoredCollectionView {
            return CGSize(width: collectionView.bounds.width, height: contentView.frame.height / 5)
        }
        return .zero
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == sponsoredCollectionView {
            let pageWidth = scrollView.frame.width
            presenter.findPageControlItemIndex(fromPageWidth: pageWidth, contentOffSetX: scrollView.contentOffset.x)
            presenter.prepareInfinityScroll(fromPageWidth: pageWidth, contentOffSetX: scrollView.contentOffset.x)
        }
    }
}
//MARK: - Alertable
extension ProductListViewController: Alertable {}

