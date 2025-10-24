//
//  ProductListPresenter.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//  
//

import Foundation

final class ProductListPresenter {
    
    var view: ProductListPresenterToViewProtocol?
    var interactor: ProductListPresenterToInteractorProtocol?
    var router: ProductListPresenterToRouterProtocol?
    
    init(view: ProductListPresenterToViewProtocol,
         interactor: ProductListPresenterToInteractorProtocol,
         router: ProductListPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


//MARK: - ProductListInteractorToPresenterProtocol
extension ProductListPresenter: ProductListInteractorToPresenterProtocol {
}

//MARK: - ProductListViewToPresenterProtocol
extension ProductListPresenter: ProductListViewToPresenterProtocol {
}
