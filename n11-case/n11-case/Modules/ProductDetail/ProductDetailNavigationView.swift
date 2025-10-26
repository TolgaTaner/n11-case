//
//  ProductDetailNavigationView.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//

import UIKit
import UIKit

// MARK: - Delegate Protocol
protocol ProductDetailNavigationViewDelegate: AnyObject {
    func backButtonDidTapped()
}

// MARK: - View
final class ProductDetailNavigationView: UIView {
    
    // Delegate
    weak var delegate: ProductDetailNavigationViewDelegate?
    
    // Back Button
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.left")
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var seperatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.down.circle")
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "magnifyingglass")
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "cart")
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(backButton)
        addSubview(seperatorView)
        addSubview(downloadButton)
        addSubview(searchButton)
        addSubview(cartButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            
            cartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cartButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -16),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            downloadButton.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -16),
            downloadButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        delegate?.backButtonDidTapped()
    }
}

