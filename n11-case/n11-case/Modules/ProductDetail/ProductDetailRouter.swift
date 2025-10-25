//
//  ProductDetailRouter.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//  
//

import UIKit.UIViewController

final class ProductDetailRouter: ProductDetailPresenterToRouterProtocol {
    
    weak var viewController: ProductDetailViewController?
    
    static func createModule() -> ProductDetailViewController? {
        let viewController = ProductDetailViewController()
        let interactor: ProductDetailPresenterToInteractorProtocol = ProductDetailInteractor()
        let router: ProductDetailPresenterToRouterProtocol = ProductDetailRouter()
        let presenter: ProductDetailViewToPresenterProtocol & ProductDetailInteractorToPresenterProtocol = ProductDetailPresenter(view: viewController, interactor: interactor, router: router)
        interactor.presenter = presenter
        viewController.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
}
