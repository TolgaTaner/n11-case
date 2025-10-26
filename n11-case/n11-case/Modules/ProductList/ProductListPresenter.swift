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
    var productList: [ListedProduct]
    var currentProductPage: Int
    var nextProductPage: Int?
    var sectionList: [ProductListSection]
    var navigationControllerDelegate: CustomNavigationControllerDelegate
    
    init(view: ProductListPresenterToViewProtocol,
         interactor: ProductListPresenterToInteractorProtocol,
         router: ProductListPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        sponsoredProductList = []
        productList = []
        currentProductPage = 1
        nextProductPage = currentProductPage
        sectionList = [.sponsored, .listing]
        navigationControllerDelegate = CustomNavigationControllerDelegate()
    }
}


//MARK: - ProductListInteractorToPresenterProtocol
extension ProductListPresenter: ProductListInteractorToPresenterProtocol {
    func productDidFetchedSuccessfully(_ sponsoredProductList: [SponsoredProduct]?, _ productList: [ListedProduct], _ currentPage: String, _ nextPage: String?) {
        if let currentPageInt = Int(currentPage) {
            currentProductPage = currentPageInt
        }
        if let nextPage = nextPage,
           let nextPageInt = Int(nextPage) {
            nextProductPage = nextPageInt
        }
        else {
            nextProductPage = nil
        }
        self.productList.append(contentsOf: productList)
        if let sponsoredProductList {
            self.sponsoredProductList = sponsoredProductList
        }
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
    func didSelectProduct(_ product: any Product) {
        router?.routeProductDetail(product)
    }
    
    func loadMoreProducts() {
        guard (nextProductPage != nil) else { return }
        currentProductPage += 1
        interactor?.getProductList(pageNumber: String(currentProductPage))
    }
    
    func getProductList() {
        interactor?.getProductList(pageNumber: String(currentProductPage))
    }
    
    func viewDidLoad() {
        view?.configureAfterViewDidLoad()
    }
    
    func viewWillAppear() {
        view?.configureAfterViewWillAppear()
    }
}
