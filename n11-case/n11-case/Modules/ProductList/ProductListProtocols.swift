//
//  ProductListProtocols.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//  
//


import UIKit.UIViewController


//MARK: - ProductListViewToPresenterProtocol
protocol ProductListViewToPresenterProtocol: AnyObject {
    var view: ProductListPresenterToViewProtocol? { get set }
    var interactor: ProductListPresenterToInteractorProtocol? { get set }
    var router: ProductListPresenterToRouterProtocol? { get set }
    var sponsoredProductList: [SponsoredProduct] { get set }
    var productList: [ListedProduct] { get set }
    var currentProductPage: Int { get set }
    var nextProductPage: Int? { get set }
    var sectionList: [ProductListSection] { get set }
    
    func getProductList()
    func viewDidLoad()
    func viewWillAppear()
    func loadMoreProducts()
    func didSelectProduct(_ product: Product)
    
}

//MARK: - ProductListPresenterToViewProtocol
protocol ProductListPresenterToViewProtocol: AnyObject {
    func configureAfterViewDidLoad()
    func configureAfterViewWillAppear()
    func showProductLists()
    func showProductListError(errorMessage: String)
}

//MARK: - ProductListPresenterToRouterProtocol
protocol ProductListPresenterToRouterProtocol: AnyObject {
    var viewController: ProductListViewController? { get set }
    static func createModule() -> UINavigationController?
    
    func routeProductDetail(_ product: Product)
}

//MARK: - ProductListPresenterToInteractorProtocol
protocol ProductListPresenterToInteractorProtocol: AnyObject {
    var presenter: ProductListInteractorToPresenterProtocol? { get set }
    var productListClient: ProductListClientProtocol { get set }

    func getProductList(pageNumber: String)
}

//MARK: - ProductListInteractorToPresenterProtocol
protocol ProductListInteractorToPresenterProtocol: AnyObject {
    func productDidFetchedSuccessfully(_ sponsoredProductList: [SponsoredProduct]?, _ productList: [ListedProduct], _ currentPage: String, _ nextPage: String?)
    func productDidFetchedWithFail(_ error: APIError)
}
