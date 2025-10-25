//
//  ProductDetailInteractor.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//  
//

import Foundation

final class ProductDetailInteractor {
    
    weak var presenter: ProductDetailInteractorToPresenterProtocol?
    
}

//MARK: - ProductDetailPresenterToInteractorProtocol
extension ProductDetailInteractor: ProductDetailPresenterToInteractorProtocol {
}
