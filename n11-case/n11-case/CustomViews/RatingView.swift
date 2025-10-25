//
//  RateView.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//


import UIKit

final class RatingView: UIView {
    
    private let stackView = UIStackView()
    private var starImageViews: [UIImageView] = []
    
    var rating: Double = 0 {
        didSet {
            updateStars()
        }
    }
    
    var maxStars: Int = 5 {
        didSet {
            setupStars()
        }
    }
    
    var starSize: CGFloat = 24 {
        didSet {
            setupStars()
        }
    }
    
    var filledStarImage: UIImage? = UIImage(systemName: "star.fill")
    var halfStarImage: UIImage? = UIImage(systemName: "star.leadinghalf.fill")
    var emptyStarImage: UIImage? = UIImage(systemName: "star")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setupStars()
    }
    
    private func setupStars() {
        starImageViews.forEach { $0.removeFromSuperview() }
        starImageViews.removeAll()
        
        for _ in 0..<maxStars {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .systemYellow
            starImageViews.append(imageView)
            stackView.addArrangedSubview(imageView)
            imageView.widthAnchor.constraint(equalToConstant: starSize).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: starSize).isActive = true
        }
        updateStars()
    }
    
    private func updateStars() {
        for (index, imageView) in starImageViews.enumerated() {
            let starValue = Double(index) + 1.0
            if rating >= starValue {
                imageView.image = filledStarImage
            } else if rating + 0.5 >= starValue {
                imageView.image = halfStarImage
            } else {
                imageView.image = emptyStarImage
            }
        }
    }
}
