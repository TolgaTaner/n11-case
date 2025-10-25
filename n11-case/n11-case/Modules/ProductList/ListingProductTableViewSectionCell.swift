//
//  ListingProductTableViewSectionCell.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//

import UIKit
protocol ListingProductTableViewSectionCellDelegate: AnyObject {
    func loadMoreProducts()
}

final class ListingProductTableViewSectionCell: UITableViewCell {
    static let reuseIdentifier = "ListingProductTableViewSectionCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListingProductCollectionViewCell.self,
                    forCellWithReuseIdentifier: ListingProductCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    
    var products: [Product] = []
    weak var delegate: ListingProductTableViewSectionCellDelegate?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        let heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        collectionViewHeightConstraint = heightConstraint
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight() {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeightConstraint?.constant = height
    }
    
    func configure(with products: [Product], delegate: ListingProductTableViewSectionCellDelegate) {
        self.products = products
        self.delegate = delegate
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
        updateCollectionViewHeight()
    }
}

// MARK: - UICollectionView DataSource & Delegate, UIScrollViewDelegate
extension ListingProductTableViewSectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListingProductCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? ListingProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: products[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = 0 
        let itemWidth = (collectionView.bounds.width - totalSpacing) / 2
        return CGSize(width: itemWidth, height: itemWidth * 1.8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                         willDisplay cell: UICollectionViewCell,
                         forItemAt indexPath: IndexPath) {
         let thresholdIndex = products.count - 1
         if indexPath.item == thresholdIndex {
             delegate?.loadMoreProducts()
         }
     }
   
}
