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
    
    static func createModule(product: Product) -> ProductDetailViewController {
        let viewController = ProductDetailViewController()
        let interactor: ProductDetailPresenterToInteractorProtocol = ProductDetailInteractor()
        let router: ProductDetailPresenterToRouterProtocol = ProductDetailRouter()
        let presenter: ProductDetailViewToPresenterProtocol & ProductDetailInteractorToPresenterProtocol = ProductDetailPresenter(view: viewController, interactor: interactor, router: router, product: product)
        interactor.presenter = presenter
        viewController.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
    func popModule() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
