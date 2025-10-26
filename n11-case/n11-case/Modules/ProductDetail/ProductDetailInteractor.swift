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
    var productDetailClient: ProductDetailClientProtocol
    
    init(presenter: ProductDetailInteractorToPresenterProtocol? = nil) {
        self.presenter = presenter
        self.productDetailClient = ProductDetailClient()
    }
    
}

//MARK: - ProductDetailPresenterToInteractorProtocol
extension ProductDetailInteractor: ProductDetailPresenterToInteractorProtocol {
    
    func getProductDetail(_ product: Product) {
        Task {
            let response = await productDetailClient.get(path: "/product", queryItems: [URLQueryItem(name: "productId", value: String(product.id))])
            switch response {
            case .success(let productResponse):
                presenter?.productDidFetchedSuccessfully(productResponse)
            case .failure(let error):
                presenter?.productDidFetchedWithFail(error)
            }
        }
    }
    
}
