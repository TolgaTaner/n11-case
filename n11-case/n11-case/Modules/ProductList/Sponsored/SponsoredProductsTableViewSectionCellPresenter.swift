//
//  SponsoredProductsTableViewSectionCellPresenter.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//

import Foundation

final class SponsoredProductsTableViewSectionCellPresenter {
    weak var view: SponsoredProductsTableViewSectionCellPresenterToViewProtocol?
    var sponsoredProductList: [SponsoredProduct]
    var sponsporedTableViewContentOffset: CGPoint
    var infinitySponsoredProductListItemCount: Int {
        sponsoredProductList.count * 3
    }
    
    init(view: SponsoredProductsTableViewSectionCellPresenterToViewProtocol? = nil, sponsoredProductList: [SponsoredProduct]) {
        self.view = view
        self.sponsoredProductList = sponsoredProductList
        self.sponsporedTableViewContentOffset = .zero
    }
}

//MARK: - SponsoredProductsTableViewSectionCellViewToPresenterProtocol
extension SponsoredProductsTableViewSectionCellPresenter: SponsoredProductsTableViewSectionCellViewToPresenterProtocol {
    
    func prepareInfinityScroll(fromPageWidth width: CGFloat, contentOffSetX: CGFloat) {
        let totalItems = sponsoredProductList.count
        let currentIndex = Int(contentOffSetX / width)
        if currentIndex < totalItems {
            let newOffset = CGPoint(x: contentOffSetX + CGFloat(totalItems) * width, y: 0)
            view?.setInfinityScroll(toPoint: newOffset)
        } else if currentIndex >= totalItems * 2 {
            let newOffset = CGPoint(x: contentOffSetX - CGFloat(totalItems) * width, y: 0)
            view?.setInfinityScroll(toPoint: newOffset)
        }
    }
    
    func findPageControlItemIndex(fromPageWidth width: CGFloat, contentOffSetX: CGFloat) {
        let currentPage = Int(contentOffSetX / width) % sponsoredProductList.count
        view?.setPageControlPageNumber(currentPage)
    }
    
    func viewDidLayoutSubviews() {
        guard sponsoredProductList.count > 0 else { return }
        if sponsporedTableViewContentOffset == .zero {
              let middleIndex = IndexPath(item: sponsoredProductList.count, section: 0)
            view?.adjustInfinityScroll(atIndex: middleIndex)
        }
    }
}
