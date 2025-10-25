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
}

//MARK: - ProductDetailPresenterToViewProtocol
protocol ProductDetailPresenterToViewProtocol: AnyObject {
}

//MARK: - ProductDetailPresenterToRouterProtocol
protocol ProductDetailPresenterToRouterProtocol: AnyObject {
    var viewController: ProductDetailViewController? { get set }
    static func createModule() -> ProductDetailViewController?
}

//MARK: - ProductDetailPresenterToInteractorProtocol
protocol ProductDetailPresenterToInteractorProtocol: AnyObject {
    var presenter: ProductDetailInteractorToPresenterProtocol? { get set }
}

//MARK: - ProductDetailInteractorToPresenterProtocol
protocol ProductDetailInteractorToPresenterProtocol: AnyObject {
}
