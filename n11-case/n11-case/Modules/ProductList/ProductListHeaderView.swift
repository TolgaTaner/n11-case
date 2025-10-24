//
//  ProductListHeaderView.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import UIKit

final class ProductListHeaderView: UIView {
    
    // MARK: - Views
    
    private lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "32108 sonuç"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Akıllı Sıralama", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filtrele", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sortButton, filterButton])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        addSubview(resultsLabel)
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            
            resultsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            resultsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
