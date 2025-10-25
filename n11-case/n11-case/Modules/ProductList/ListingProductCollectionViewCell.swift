//
//  ListingProductCollectionViewCell.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import UIKit
import Kingfisher

final class ListingProductCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ListingProductCollectionViewCell"
    
    // MARK: - UI Elements
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private lazy var discountPriceView: DiscountPriceView = {
        let discountPriceView = DiscountPriceView()
        discountPriceView.translatesAutoresizingMaskIntoConstraints = false
        return discountPriceView
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.maxStars = 5
        view.starSize = 10
        return view
    }()
    
    private let sellerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.separator.cgColor
        
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(discountPriceView)
        contentView.addSubview(sellerLabel)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            sellerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            sellerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            sellerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                        
            ratingView.topAnchor.constraint(equalTo: sellerLabel.bottomAnchor, constant: 4),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            ratingView.heightAnchor.constraint(equalToConstant: 12),
            ratingView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            
            discountPriceView.heightAnchor.constraint(equalToConstant: 30),
            discountPriceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            discountPriceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            discountPriceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        discountPriceView.configure(originalPrice: product.price, discountedPrice: product.instantDiscountPrice)
        sellerLabel.text = product.sellerName
        ratingView.isHidden = product.rate == nil
        if let rating = product.rate {
            ratingView.rating = rating
        }
        
        if let url = URL(string: product.image) {
            let processor = DownsamplingImageProcessor(size: productImageView.bounds.size)
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo")?.withTintColor(.lightGray),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ])
        } else {
            productImageView.image = UIImage(systemName: "photo")?.withTintColor(.lightGray)
        }
    }
}
