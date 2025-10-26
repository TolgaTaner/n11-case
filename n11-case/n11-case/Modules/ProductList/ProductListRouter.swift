//
//  ProductListRouter.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//  
//

import UIKit.UIViewController

final class ProductListRouter: ProductListPresenterToRouterProtocol {
    
    weak var viewController: ProductListViewController?
    
    static func createModule() -> UINavigationController? {
        let viewController = ProductListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let interactor: ProductListPresenterToInteractorProtocol = ProductListInteractor()
        let router: ProductListPresenterToRouterProtocol = ProductListRouter()
        let presenter: ProductListViewToPresenterProtocol & ProductListInteractorToPresenterProtocol = ProductListPresenter(view: viewController, interactor: interactor, router: router)
        interactor.presenter = presenter
        viewController.presenter = presenter
        router.viewController = viewController
        return navigationController
    }
    
    func routeProductDetail(_ product: Product) {
        let productDetailModule = ProductDetailRouter.createModule(product: product)
        viewController?.navigationController?.pushViewController(productDetailModule, animated: true)
    }
    
}
