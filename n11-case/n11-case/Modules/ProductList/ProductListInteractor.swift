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
    var productListClient: ProductListClientProtocol
    
    init() {
        productListClient = ProductListClient()
    }
}

//MARK: - ProductListPresenterToInteractorProtocol
extension ProductListInteractor: ProductListPresenterToInteractorProtocol {
    func getProductList(pageNumber: String) {
        Task {
            let result = await productListClient.get(path: "/listing/\(pageNumber)", queryItems: nil)
            switch result {
            case .success(let response):
                presenter?.productDidFetchedSuccessfully(response.sponsoredProducts, response.products)
            case .failure(let failure):
                presenter?.productDidFetchedWithFail(failure)
            }
        }
    }
}
