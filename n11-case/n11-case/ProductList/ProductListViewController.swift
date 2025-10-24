//
//  ProductListViewController.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//  
//

import UIKit.UIViewController

final class ProductListViewController: UIViewController {
    
    var presenter: ProductListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}
//MARK: - ProductListPresenterToViewProtocol
extension ProductListViewController: ProductListPresenterToViewProtocol {
}
