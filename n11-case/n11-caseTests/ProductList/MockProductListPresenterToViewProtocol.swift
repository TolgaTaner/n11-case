//
//  MockProductListPresenterToViewProtocol.swift
//  n11-caseTests
//
//  Created by Tolga Taner on 26.10.2025.
//

import Foundation
@testable import n11_case

final class MockProductListPresenterToViewProtocol: ProductListPresenterToViewProtocol {

    var invokedConfigureAfterViewDidLoad = false
    var invokedConfigureAfterViewDidLoadCount = 0

    func configureAfterViewDidLoad() {
        invokedConfigureAfterViewDidLoad = true
        invokedConfigureAfterViewDidLoadCount += 1
    }

    var invokedConfigureAfterViewWillAppear = false
    var invokedConfigureAfterViewWillAppearCount = 0

    func configureAfterViewWillAppear() {
        invokedConfigureAfterViewWillAppear = true
        invokedConfigureAfterViewWillAppearCount += 1
    }

    var invokedShowProductLists = false
    var invokedShowProductListsCount = 0

    func showProductLists() {
        invokedShowProductLists = true
        invokedShowProductListsCount += 1
    }

    var invokedShowProductListError = false
    var invokedShowProductListErrorCount = 0
    var invokedShowProductListErrorParameters: (errorMessage: String, Void)?
    var invokedShowProductListErrorParametersList = [(errorMessage: String, Void)]()

    func showProductListError(errorMessage: String) {
        invokedShowProductListError = true
        invokedShowProductListErrorCount += 1
        invokedShowProductListErrorParameters = (errorMessage, ())
        invokedShowProductListErrorParametersList.append((errorMessage, ()))
    }
}
