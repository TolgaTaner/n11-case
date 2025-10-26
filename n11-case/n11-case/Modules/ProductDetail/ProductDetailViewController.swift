//
//  ProductDetailViewController.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//
//

import UIKit.UIViewController

final class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailViewToPresenterProtocol!
    
    private lazy var navigationView: ProductDetailNavigationView = {
        let navigationView: ProductDetailNavigationView = ProductDetailNavigationView()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.backgroundColor = .white
        return navigationView
    }()
    
    private lazy var contentView: UIView = {
        let contentView: UIView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var scrollViewContentView: UIView = {
        let contentView: UIView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductDetailImagesCollectionViewCell.self, forCellWithReuseIdentifier: ProductDetailImagesCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .separator
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.maxStars = 5
        view.starSize = 10
        view.isHidden = true
        return view
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sellerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [newPriceLabel, oldPriceLabel, discountLabel])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var newPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seperatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter?.viewDidLayoutSubviews()
    }
    
    override func loadView() {
        super.loadView()
        setupContentView()
        setupNavigationView()
        setupScrollView()
        setupContent()
    }
    
    private func setupContent() {
        scrollViewContentView.addSubview(imageCollectionView)
        scrollViewContentView.addSubview(pageControl)
        scrollViewContentView.addSubview(titleLabel)
        scrollViewContentView.addSubview(sellerLabel)
        scrollViewContentView.addSubview(ratingView)
        scrollViewContentView.addSubview(rateLabel)
        scrollViewContentView.addSubview(priceStackView)
        scrollViewContentView.addSubview(seperatorView)
        
        NSLayoutConstraint.activate([
            
            imageCollectionView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: 10),
            imageCollectionView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 400),
            
            pageControl.bottomAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 25),
            pageControl.centerXAnchor.constraint(equalTo: scrollViewContentView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -16),
            
            sellerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            sellerLabel.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 16),
            sellerLabel.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -16),
            
            ratingView.topAnchor.constraint(equalTo: sellerLabel.bottomAnchor, constant: 4),
            ratingView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 16),
            ratingView.heightAnchor.constraint(equalToConstant: 14),
            
            rateLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 4),
            
            seperatorView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor),
            seperatorView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 5),
            seperatorView.heightAnchor.constraint(equalToConstant: 5),
            
            priceStackView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 5),
            priceStackView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 16),
            priceStackView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor, constant: -20),
            
            
            
        ])
        scrollViewContentView.bringSubviewToFront(pageControl)
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
    
    private func setupScrollView() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(scrollViewContentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            scrollViewContentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollViewContentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollViewContentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollViewContentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            scrollViewContentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
}
extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.infinityImagesItemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailImagesCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductDetailImagesCollectionViewCell,
              let urlString = presenter.selectedProduct?.images[indexPath.row % (presenter.selectedProduct?.images.count ?? 0)] else {
            return UICollectionViewCell()
        }
        cell.configure(with: urlString)
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        presenter.collectionViewContentOffset = scrollView.contentOffset
        let pageWidth = scrollView.frame.width
        presenter.findPageControlItemIndex(fromPageWidth: pageWidth, contentOffSetX: scrollView.contentOffset.x)
        presenter.prepareInfinityScroll(fromPageWidth: pageWidth, contentOffSetX: scrollView.contentOffset.x)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter.collectionViewContentOffset = scrollView.contentOffset
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: - Alertable
extension ProductDetailViewController: Alertable {}
//MARK: - ProductDetailPresenterToViewProtocol
extension ProductDetailViewController: ProductDetailPresenterToViewProtocol {
    func showPrice(newPrice: String, oldPrice: String, percentage: String) {
        oldPriceLabel.attributedText = NSAttributedString(
            string: oldPrice,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        newPriceLabel.text = newPrice
        discountLabel.text = percentage
    }
    
    func setPageControlPageNumber(_ number: Int) {
        pageControl.currentPage = number
    }
    
    func setInfinityScroll(toPoint point: CGPoint) {
        imageCollectionView.setContentOffset(point, animated: false)
    }
    
    func adjustInfinityScroll(atIndex index: IndexPath) {
        imageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        presenter.collectionViewContentOffset = scrollView.contentOffset
    }
    
    func showProduct(_ product: DetailedProduct) {
        titleLabel.text = presenter.selectedProduct?.title
        sellerLabel.text = presenter.selectedProduct?.sellerName
        ratingView.isHidden = presenter.product.rate == nil
        if let rating = presenter.product.rate {
            ratingView.rating = rating
        }
        imageCollectionView.reloadData()
        pageControl.numberOfPages = product.images.count
        rateLabel.text = String(product.rate)
        seperatorView.isHidden = false
        LoadingIndicatorView.shared.hide()
    }
    
    func showProductListError(errorMessage: String) {
        showAlert(title: "N11", message: errorMessage)
        LoadingIndicatorView.shared.hide()
    }
    
    func configureAfterViewDidLoad() {
        view.backgroundColor = .white
        navigationView.delegate = self
        LoadingIndicatorView.shared.show()
        presenter.getProductDetail()
    }
    
}
//MARK: - ProductDetailNavigationViewDelegate
extension ProductDetailViewController: ProductDetailNavigationViewDelegate {
    func backButtonDidTapped() {
        presenter.backButtonDidTapped()
    }
}
