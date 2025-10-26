//
//  MockProductListPresenterToRouterProtocol.swift
//  n11-caseTests
//
//  Created by Tolga Taner on 26.10.2025.
//

import UIKit
@testable import n11_case

final class MockProductListPresenterToRouterProtocol: ProductListPresenterToRouterProtocol {


    var invokedViewControllerSetter = false
    var invokedViewControllerSetterCount = 0
    var invokedViewController: ProductListViewController?
    var invokedViewControllerList = [ProductListViewController?]()
    var invokedViewControllerGetter = false
    var invokedViewControllerGetterCount = 0
    var stubbedViewController: ProductListViewController!

    var viewController: ProductListViewController? {
        set {
            invokedViewControllerSetter = true
            invokedViewControllerSetterCount += 1
            invokedViewController = newValue
            invokedViewControllerList.append(newValue)
        }
        get {
            invokedViewControllerGetter = true
            invokedViewControllerGetterCount += 1
            return stubbedViewController
        }
    }

    var invokedRouteProductDetail = false
    var invokedRouteProductDetailCount = 0
    var invokedRouteProductDetailParameters: (product: Product, Void)?
    var invokedRouteProductDetailParametersList = [(product: Product, Void)]()

    func routeProductDetail(_ product: Product) {
        invokedRouteProductDetail = true
        invokedRouteProductDetailCount += 1
        invokedRouteProductDetailParameters = (product, ())
        invokedRouteProductDetailParametersList.append((product, ()))
    }
    
    static func createModule() -> UINavigationController? {
        UINavigationController()
    }
}
