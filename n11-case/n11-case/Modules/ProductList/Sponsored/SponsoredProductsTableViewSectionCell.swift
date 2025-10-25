//
//  SponsoredProductsTableViewSectionCell.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//

import UIKit

final class SponsoredProductsTableViewSectionCell: UITableViewCell {
    static let reuseIdentifier = "SponsoredProductsTableViewCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(SponsoredProductCollectionViewCell.self, forCellWithReuseIdentifier: SponsoredProductCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .separator
        pageControl.currentPageIndicatorTintColor = .systemRed
        return pageControl
    }()
    
    var presenter: SponsoredProductsTableViewSectionCellViewToPresenterProtocol!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        presenter?.viewDidLayoutSubviews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(sponsoredProductList: [SponsoredProduct]) {
        self.presenter = SponsoredProductsTableViewSectionCellPresenter(view: self, sponsoredProductList: sponsoredProductList)
        pageControl.numberOfPages = presenter.sponsoredProductList.count
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
}
//MARK: - SponsoredProductsTableViewSectionCellPresenterToViewProtocol
extension SponsoredProductsTableViewSectionCell: SponsoredProductsTableViewSectionCellPresenterToViewProtocol {
        func setPageControlPageNumber(_ number: Int) {
            pageControl.currentPage = number
        }
        
        func setInfinityScroll(toPoint point: CGPoint) {
            collectionView.setContentOffset(point, animated: false)
        }
        
        func adjustInfinityScroll(atIndex index: IndexPath) {
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        }
}

//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate
extension SponsoredProductsTableViewSectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.infinitySponsoredProductListItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SponsoredProductCollectionViewCell.reuseIdentifier, for: indexPath) as? SponsoredProductCollectionViewCell {
            let realIndex = indexPath.item % presenter.sponsoredProductList.count
            let product = presenter.sponsoredProductList[realIndex]
            cell.configure(with: product)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: contentView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        presenter.sponsporedTableViewContentOffset = scrollView.contentOffset
        let pageWidth = scrollView.frame.width
        presenter.findPageControlItemIndex(fromPageWidth: pageWidth, contentOffSetX: scrollView.contentOffset.x)
        presenter.prepareInfinityScroll(fromPageWidth: pageWidth, contentOffSetX: scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        presenter.sponsporedTableViewContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter.sponsporedTableViewContentOffset = scrollView.contentOffset
    }
}
