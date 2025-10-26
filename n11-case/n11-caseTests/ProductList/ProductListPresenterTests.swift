//
//  ProductListPresenterTests.swift
//  n11-caseTests
//
//  Created by Tolga Taner on 24.10.2025.
//

import XCTest
@testable import n11_case

final class ProductListPresenterTests: XCTestCase {
    
    
    private var presenter: ProductListPresenter!
    private var view: MockProductListPresenterToViewProtocol!
    private var router: MockProductListPresenterToRouterProtocol!
    private var interactor: MockProductListPresenterToInteractorProtocol!
    
    override func setUp() {
        super.setUp()
        view = MockProductListPresenterToViewProtocol()
        router = MockProductListPresenterToRouterProtocol()
        interactor = MockProductListPresenterToInteractorProtocol()
        presenter = ProductListPresenter(view: view, interactor: interactor, router: router)
    }
    
    func testConfigureCalledAfterViewDidLoad() {
        XCTAssertFalse(view.invokedConfigureAfterViewDidLoad)
        XCTAssertEqual(view.invokedConfigureAfterViewDidLoadCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedConfigureAfterViewDidLoad)
        XCTAssertEqual(view.invokedConfigureAfterViewDidLoadCount, 1)
    }
    
    func testConfigureCalledAfterViewWillAppear() {
        XCTAssertFalse(view.invokedConfigureAfterViewWillAppear)
        XCTAssertEqual(view.invokedConfigureAfterViewWillAppearCount, 0)
        
        presenter.viewWillAppear()
        
        XCTAssertTrue(view.invokedConfigureAfterViewWillAppear)
        XCTAssertEqual(view.invokedConfigureAfterViewWillAppearCount, 1)
    }
    
    func testProductListShouldInvokeProductList() {
        XCTAssertFalse(interactor.invokedGetProductList)
        XCTAssertEqual(interactor.invokedGetProductListCount, 0)
        
        presenter.getProductList()
        
        XCTAssertTrue(interactor.invokedGetProductList)
        XCTAssertEqual(interactor.invokedGetProductListCount, 1)
    }
    
    func testLoadMoreProductsShouldInvokeProductList() {
        XCTAssertFalse(interactor.invokedGetProductList)
        XCTAssertEqual(interactor.invokedGetProductListCount, 0)
        
        presenter.currentProductPage = 0
        presenter.loadMoreProducts()
        
        XCTAssertEqual(presenter.currentProductPage, 1)
        XCTAssertTrue(interactor.invokedGetProductList)
        XCTAssertEqual(interactor.invokedGetProductListCount, 1)
    }
    
    func testProductSelectionShouldInvokeProductDetail() {
        XCTAssertFalse(router.invokedRouteProductDetail)
        XCTAssertEqual(router.invokedRouteProductDetailCount, 0)
        
        if let product = SponsoredProduct.sample.first {
            presenter.didSelectProduct(product)
        }
        
        XCTAssertTrue(router.invokedRouteProductDetail)
        XCTAssertEqual(router.invokedRouteProductDetailCount, 1)
    }
    
}
