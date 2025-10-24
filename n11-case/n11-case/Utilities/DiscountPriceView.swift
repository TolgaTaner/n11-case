//
//  DiscountPriceView.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import UIKit

final class DiscountPriceView: UIView {
    
    private lazy var discountView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var newPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [oldPriceLabel, newPriceLabel])
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let calculator: PriceCalculator = PriceCalculator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(discountView)
        discountView.addSubview(discountLabel)
        addSubview(priceStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            discountLabel.topAnchor.constraint(equalTo: discountView.topAnchor, constant: 2),
            discountLabel.bottomAnchor.constraint(equalTo: discountView.bottomAnchor, constant: -2),
            discountLabel.leadingAnchor.constraint(equalTo: discountView.leadingAnchor, constant: 6),
            discountLabel.trailingAnchor.constraint(equalTo: discountView.trailingAnchor, constant: -6),
            
            discountView.leadingAnchor.constraint(equalTo: leadingAnchor),
            discountView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            priceStackView.leadingAnchor.constraint(equalTo: discountView.trailingAnchor, constant: 8),
            priceStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(originalPrice: Double, discountedPrice: Double?) {
        if let discountedPrice {
            discountView.isHidden = false
            newPriceLabel.isHidden = false
            
            let discount = calculator.calculateDiscountPercentage(originalPrice: originalPrice, discountedPrice: discountedPrice)
            discountLabel.text = discount
            
            oldPriceLabel.attributedText = NSAttributedString(
                string: calculator.getPrice(from: originalPrice),
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            newPriceLabel.text = calculator.getPrice(from: discountedPrice)
        } else {
            discountView.isHidden = true
            newPriceLabel.isHidden = true
            oldPriceLabel.attributedText = nil
            oldPriceLabel.text = calculator.getPrice(from: originalPrice)
        }
    }
}
