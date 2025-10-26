//
//  ProductDetailResponse.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//

import Foundation

struct ProductDetailResponse: Codable {
    let title, description: String
    let images: [String]
    let price, instantDiscountPrice: Int
    let rate: Double
    let sellerName: String
}

struct DetailedProduct {
    let title, description: String
    let images: [String]
    let price, instantDiscountPrice: Int
    let rate: Double
    let sellerName: String
}
