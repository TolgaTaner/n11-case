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
    var sponsoredProductList: [SponsoredProduct]
    var infinitySponsoredProductListItemCount: Int {
        sponsoredProductList.count * 3
    }
    var productList: [Product]
    var currentProductPage: String
    
    init(view: ProductListPresenterToViewProtocol,
         interactor: ProductListPresenterToInteractorProtocol,
         router: ProductListPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        sponsoredProductList = []
        productList = []
        currentProductPage = "1"
    }
}


//MARK: - ProductListInteractorToPresenterProtocol
extension ProductListPresenter: ProductListInteractorToPresenterProtocol {
    func productDidFetchedSuccessfully(_ sponsoredProductList: [SponsoredProduct], _ productList: [Product]) {
        self.productList = productList
        self.sponsoredProductList = sponsoredProductList
        DispatchQueue.main.async {
            self.view?.showProductLists()
        }
    }
    
    func productDidFetchedWithFail(_ error: APIError) {
        DispatchQueue.main.async {
            self.view?.showProductListError(errorMessage: error.localizedDescription)
        }
    }
}

//MARK: - ProductListViewToPresenterProtocol
extension ProductListPresenter: ProductListViewToPresenterProtocol {
    func prepareInfinityScroll(fromPageWidth width: CGFloat, contentOffSetX: CGFloat) {
        let totalItems = sponsoredProductList.count
        let currentIndex = Int(contentOffSetX / width)
        if currentIndex < totalItems {
            let newOffset = CGPoint(x: contentOffSetX + CGFloat(totalItems) * width, y: 0)
            view?.setInfinityScroll(toPoint: newOffset)
        } else if currentIndex >= totalItems * 2 {
            let newOffset = CGPoint(x: contentOffSetX - CGFloat(totalItems) * width, y: 0)
            view?.setInfinityScroll(toPoint: newOffset)
        }
    }
    
    func findPageControlItemIndex(fromPageWidth width: CGFloat, contentOffSetX: CGFloat) {
        let currentPage = Int(contentOffSetX / width) % sponsoredProductList.count
        view?.setPageControlPageNumber(currentPage)
    }
    
    func getProductList() {
        interactor?.getProductList(pageNumber: currentProductPage)
    }
    
    func viewDidLoad() {
        view?.configureAfterViewDidLoad()
    }
    
    func viewWillAppear() {
        view?.configureAfterViewWillAppear()
    }
}
