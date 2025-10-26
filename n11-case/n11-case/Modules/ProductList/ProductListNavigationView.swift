//
//  NavigationView.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import UIKit

final class ProductListNavigationView: UIView {
    
    private lazy var seperatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "iphone 11"
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.font = .systemFont(ofSize: 14)
        
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        
        textField.leftView = containerView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(searchTextField)
        addSubview(seperatorView)
        
        NSLayoutConstraint.activate([
            
            searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            

            seperatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

