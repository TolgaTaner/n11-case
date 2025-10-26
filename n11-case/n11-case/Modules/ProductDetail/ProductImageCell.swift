//
//  ProductImageCell.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//

import Kingfisher
import UIKit

final class ProductDetailImagesCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ProductDetailImagesCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with urlString: String) {
        if let url = URL(string: urlString) {
            imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
    }
}
