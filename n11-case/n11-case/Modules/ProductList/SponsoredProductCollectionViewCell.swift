//
//  SponsoredProductCollectionViewCell.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import UIKit
import Kingfisher

final class SponsoredProductCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "SponsoredProductCollectionViewCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var discountPriceView: DiscountPriceView = {
        let discountPriceView: DiscountPriceView = DiscountPriceView()
        discountPriceView.translatesAutoresizingMaskIntoConstraints = false
        return discountPriceView
    }()
    
    private let ratingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.maxStars = 5
        view.starSize = 10
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(discountPriceView)
        contentView.addSubview(ratingView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            discountPriceView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            discountPriceView.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: discountPriceView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            ratingView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 4),
            ratingView.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor),
            ratingView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }

    func configure(with product: SponsoredProduct) {
        titleLabel.text = product.title
        discountPriceView.configure(originalPrice: product.price, discountedPrice: product.instantDiscountPrice)
        if let rate = product.rate {
            ratingView.isHidden = false
            ratingView.rating = rate
        }
        else {
            ratingView.isHidden = true
        }
        guard let url: URL = URL(string: product.image) else { return }
        productImageView.kf.setImage(with: url)
    }
    
}
