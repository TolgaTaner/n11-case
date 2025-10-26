//
//  MockProductListPresenterToInteractorProtocol.swift
//  n11-caseTests
//
//  Created by Tolga Taner on 26.10.2025.
//

import Foundation
@testable import n11_case

final class MockProductListPresenterToInteractorProtocol: ProductListPresenterToInteractorProtocol {

    var invokedPresenterSetter = false
    var invokedPresenterSetterCount = 0
    var invokedPresenter: ProductListInteractorToPresenterProtocol?
    var invokedPresenterList = [ProductListInteractorToPresenterProtocol?]()
    var invokedPresenterGetter = false
    var invokedPresenterGetterCount = 0
    var stubbedPresenter: ProductListInteractorToPresenterProtocol!

    var presenter: ProductListInteractorToPresenterProtocol? {
        set {
            invokedPresenterSetter = true
            invokedPresenterSetterCount += 1
            invokedPresenter = newValue
            invokedPresenterList.append(newValue)
        }
        get {
            invokedPresenterGetter = true
            invokedPresenterGetterCount += 1
            return stubbedPresenter
        }
    }

    var invokedProductListClientSetter = false
    var invokedProductListClientSetterCount = 0
    var invokedProductListClient: ProductListClientProtocol?
    var invokedProductListClientList = [ProductListClientProtocol]()
    var invokedProductListClientGetter = false
    var invokedProductListClientGetterCount = 0
    var stubbedProductListClient: ProductListClientProtocol!

    var productListClient: ProductListClientProtocol {
        set {
            invokedProductListClientSetter = true
            invokedProductListClientSetterCount += 1
            invokedProductListClient = newValue
            invokedProductListClientList.append(newValue)
        }
        get {
            invokedProductListClientGetter = true
            invokedProductListClientGetterCount += 1
            return stubbedProductListClient
        }
    }

    var invokedGetProductList = false
    var invokedGetProductListCount = 0
    var invokedGetProductListParameters: (pageNumber: String, Void)?
    var invokedGetProductListParametersList = [(pageNumber: String, Void)]()

    func getProductList(pageNumber: String) {
        invokedGetProductList = true
        invokedGetProductListCount += 1
        invokedGetProductListParameters = (pageNumber, ())
        invokedGetProductListParametersList.append((pageNumber, ()))
    }
}


