//
//  ProductListProtocols.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//  
//


import UIKit.UIViewController


//MARK: - ProductListViewToPresenterProtocol
protocol ProductListViewToPresenterProtocol: AnyObject {
    var view: ProductListPresenterToViewProtocol? { get set }
    var interactor: ProductListPresenterToInteractorProtocol? { get set }
    var router: ProductListPresenterToRouterProtocol? { get set }
}

//MARK: - ProductListPresenterToViewProtocol
protocol ProductListPresenterToViewProtocol: AnyObject {
}

//MARK: - ProductListPresenterToRouterProtocol
protocol ProductListPresenterToRouterProtocol: AnyObject {
    var viewController: ProductListViewController? { get set }
    static func createModule() -> UINavigationController?
}

//MARK: - ProductListPresenterToInteractorProtocol
protocol ProductListPresenterToInteractorProtocol: AnyObject {
    var presenter: ProductListInteractorToPresenterProtocol? { get set }
}

//MARK: - ProductListInteractorToPresenterProtocol
protocol ProductListInteractorToPresenterProtocol: AnyObject {
}
