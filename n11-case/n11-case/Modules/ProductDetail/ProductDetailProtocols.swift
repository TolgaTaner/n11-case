//
//  ProductDetailProtocols.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//  
//


import UIKit.UIViewController


//MARK: - ProductDetailViewToPresenterProtocol
protocol ProductDetailViewToPresenterProtocol: AnyObject {
    var view: ProductDetailPresenterToViewProtocol? { get set }
    var interactor: ProductDetailPresenterToInteractorProtocol? { get set }
    var router: ProductDetailPresenterToRouterProtocol? { get set }
    var product: Product { get set }
    var selectedProduct: DetailedProduct? { get set }
    var infinityImagesItemCount: Int { get }
    var collectionViewContentOffset: CGPoint { get set }
    var priceCalculator: PriceCalculator { get set }
    
    func viewDidLoad()
    func getProductDetail()
    func viewDidLayoutSubviews()
    func findPageControlItemIndex(fromPageWidth width: CGFloat, contentOffSetX: CGFloat)
    func prepareInfinityScroll(fromPageWidth width: CGFloat, contentOffSetX: CGFloat)
    func backButtonDidTapped()
}

//MARK: - ProductDetailPresenterToViewProtocol
protocol ProductDetailPresenterToViewProtocol: AnyObject {
    
    func configureAfterViewDidLoad()
    func showProduct(_ product: DetailedProduct)
    func showProductListError(errorMessage: String)
    func adjustInfinityScroll(atIndex index: IndexPath)
    func setInfinityScroll(toPoint point: CGPoint)
    func setPageControlPageNumber(_ number: Int)
    func showPrice(newPrice: String, oldPrice: String, percentage: String)
}

//MARK: - ProductDetailPresenterToRouterProtocol
protocol ProductDetailPresenterToRouterProtocol: AnyObject {
    var viewController: ProductDetailViewController? { get set }
    static func createModule(product: Product) -> ProductDetailViewController
    
    func popModule()
}

//MARK: - ProductDetailPresenterToInteractorProtocol
protocol ProductDetailPresenterToInteractorProtocol: AnyObject {
    var presenter: ProductDetailInteractorToPresenterProtocol? { get set }
    var productDetailClient: ProductDetailClientProtocol { get set }
    
    func getProductDetail(_ product: Product)
}

//MARK: - ProductDetailInteractorToPresenterProtocol
protocol ProductDetailInteractorToPresenterProtocol: AnyObject {
    func productDidFetchedSuccessfully(_ product: ProductDetailResponse)
    func productDidFetchedWithFail(_ error: APIError)
}
