//
//  SponsoredProductListProtocols.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//

import Foundation

protocol SponsoredProductsTableViewSectionCellPresenterToViewProtocol: AnyObject {
    func adjustInfinityScroll(atIndex index: IndexPath)
    func setInfinityScroll(toPoint point: CGPoint)
    func setPageControlPageNumber(_ number: Int)
}

protocol SponsoredProductsTableViewSectionCellViewToPresenterProtocol: AnyObject {
    var sponsoredProductList: [SponsoredProduct] { get set }
    var infinitySponsoredProductListItemCount: Int { get }
    var sponsporedTableViewContentOffset: CGPoint { get set }
    
    func viewDidLayoutSubviews()
    func findPageControlItemIndex(fromPageWidth width: CGFloat, contentOffSetX: CGFloat)
    func prepareInfinityScroll(fromPageWidth width: CGFloat, contentOffSetX: CGFloat)
}
