//
//  ProductDetailPresenter.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//  
//

import Foundation

final class ProductDetailPresenter {
    
    var view: ProductDetailPresenterToViewProtocol?
    var interactor: ProductDetailPresenterToInteractorProtocol?
    var router: ProductDetailPresenterToRouterProtocol?
    
    init(view: ProductDetailPresenterToViewProtocol,
         interactor: ProductDetailPresenterToInteractorProtocol,
         router: ProductDetailPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


//MARK: - ProductDetailInteractorToPresenterProtocol
extension ProductDetailPresenter: ProductDetailInteractorToPresenterProtocol {
}

//MARK: - ProductDetailViewToPresenterProtocol
extension ProductDetailPresenter: ProductDetailViewToPresenterProtocol {
}
