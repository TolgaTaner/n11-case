//
//  ProductListInteractor.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//  
//

import Foundation

final class ProductListInteractor {
    
    weak var presenter: ProductListInteractorToPresenterProtocol?
    
}

//MARK: - ProductListPresenterToInteractorProtocol
extension ProductListInteractor: ProductListPresenterToInteractorProtocol {
}
