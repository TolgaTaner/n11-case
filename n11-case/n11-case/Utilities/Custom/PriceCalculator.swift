//
//  PriceCalculator.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import Foundation

final class PriceCalculator {
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.positiveSuffix = " TL"
        formatter.negativeSuffix = " TL"
        return formatter
    }()
    
    func calculateDiscountPercentage(originalPrice: Double, discountedPrice: Double) -> String? {
        guard originalPrice > 0 else { return nil }
        let discount = (originalPrice - discountedPrice) / originalPrice * 100
        if Int(round(discount)) == 0 {
            return nil
        }
        return "%\(Int(round(discount)))"
    }
    
    func getPrice(from price: Double) -> String {
           formatter.string(from: NSNumber(value: price)) ?? "\(price) TL"
    }
    
}
