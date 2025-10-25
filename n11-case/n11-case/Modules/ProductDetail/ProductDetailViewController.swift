//
//  ProductDetailViewController.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//  
//

import UIKit.UIViewController

final class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
//MARK: - ProductDetailPresenterToViewProtocol
extension ProductDetailViewController: ProductDetailPresenterToViewProtocol {
}
