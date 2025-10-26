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
    var product: Product
    var selectedProduct: DetailedProduct?
    var collectionViewContentOffset: CGPoint
    var infinityImagesItemCount: Int {
        (selectedProduct?.images.count ?? 0) * 3 
    }
    var priceCalculator: PriceCalculator
    
    init(view: ProductDetailPresenterToViewProtocol,
         interactor: ProductDetailPresenterToInteractorProtocol,
         router: ProductDetailPresenterToRouterProtocol?,
         product: Product) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.product = product
        selectedProduct = nil
        collectionViewContentOffset = .zero
        priceCalculator = PriceCalculator()
    }
}


//MARK: - ProductDetailInteractorToPresenterProtocol
extension ProductDetailPresenter: ProductDetailInteractorToPresenterProtocol {
    func productDidFetchedSuccessfully(_ product: ProductDetailResponse) {
        selectedProduct = DetailedProduct(title: product.title, description: product.description, images: product.images, price: product.price, instantDiscountPrice: product.instantDiscountPrice, rate: product.rate, sellerName: product.sellerName)
        let percentage = priceCalculator.calculateDiscountPercentage(originalPrice: Double(product.price), discountedPrice: Double(product.instantDiscountPrice))
        let oldPrice = priceCalculator.getPrice(from: Double(product.price))
        let newPrice = priceCalculator.getPrice(from: Double(product.instantDiscountPrice))
        
        DispatchQueue.main.async {
            if let selectedProduct = self.selectedProduct {
                self.view?.showProduct(selectedProduct)
                self.view?.showPrice(newPrice: newPrice, oldPrice: oldPrice, percentage: percentage ?? String())
            }
        }
    }
    
    func productDidFetchedWithFail(_ error: APIError) {
        DispatchQueue.main.async {
            self.view?.showProductListError(errorMessage: error.localizedDescription)
        }
    }
}

//MARK: - ProductDetailViewToPresenterProtocol
extension ProductDetailPresenter: ProductDetailViewToPresenterProtocol {
    func backButtonDidTapped() {
        router?.popModule()
    }
    
    func prepareInfinityScroll(fromPageWidth width: CGFloat, contentOffSetX: CGFloat) {
        guard let totalItems = selectedProduct?.images.count else { return }
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
        guard let totalItems = selectedProduct?.images.count else { return }
        let currentPage = Int(contentOffSetX / width) % totalItems
        view?.setPageControlPageNumber(currentPage)
    }
    
    func viewDidLayoutSubviews() {
        guard let totalItems = selectedProduct?.images.count, totalItems > 0 else { return }
        if collectionViewContentOffset == .zero {
              let middleIndex = IndexPath(item: totalItems, section: 0)
            view?.adjustInfinityScroll(atIndex: middleIndex)
        }
    }
    
    func getProductDetail() {
        interactor?.getProductDetail(product)
    }
    
    func viewDidLoad() {
        view?.configureAfterViewDidLoad()
    }
}
