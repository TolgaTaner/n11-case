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
    var productList: [Product] { get set }
    var currentProductPage: String { get set }
    var infinitySponsoredProductListItemCount: Int { get }
    
    func getProductList()
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    
    func findPageControlItemIndex(fromPageWidth width: CGFloat, contentOffSetX: CGFloat)
    func prepareInfinityScroll(fromPageWidth width: CGFloat, contentOffSetX: CGFloat)
    
}

//MARK: - ProductListPresenterToViewProtocol
protocol ProductListPresenterToViewProtocol: AnyObject {
    func configureAfterViewDidLoad()
    func configureAfterViewWillAppear()
    func showProductLists()
    func setPageControlPageNumber(_ number: Int)
    func showProductListError(errorMessage: String)
    func setInfinityScroll(toPoint point: CGPoint)
}

//MARK: - ProductListPresenterToRouterProtocol
protocol ProductListPresenterToRouterProtocol: AnyObject {
    var viewController: ProductListViewController? { get set }
    static func createModule() -> UINavigationController?
}

//MARK: - ProductListPresenterToInteractorProtocol
protocol ProductListPresenterToInteractorProtocol: AnyObject {
    var presenter: ProductListInteractorToPresenterProtocol? { get set }
    var productListClient: ProductListClientProtocol { get set }

    func getProductList(pageNumber: String)
}

//MARK: - ProductListInteractorToPresenterProtocol
protocol ProductListInteractorToPresenterProtocol: AnyObject {
      func productDidFetchedSuccessfully(_ sponsoredProductList: [SponsoredProduct], _ productList: [Product])
      func productDidFetchedWithFail(_ error: APIError)
}
