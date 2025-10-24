//
//  HomeDataSource.swift
//  n11-home
//
//  Created by Tolga Taner on 22.10.2025.
//

import Foundation

struct ProductListResponse<T: Model>: Model {
    let page, nextPage, publishedAt: String
    let sponsoredProducts, products: [T]

    enum CodingKeys: String, CodingKey {
        case page, nextPage
        case publishedAt = "published_at"
        case sponsoredProducts, products
    }
}

// MARK: - Product
struct Product: Model {
    let id: Int
    let title, image: String
    let price: Double
    let instantDiscountPrice, rate: Double?
    let sellerName: String?
}
