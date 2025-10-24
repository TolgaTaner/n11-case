import Foundation

struct ProductListResponse: Decodable {
    let page, nextPage, publishedAt: String
    let sponsoredProducts: [SponsoredProduct]
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case page, nextPage
        case publishedAt = "published_at"
        case sponsoredProducts, products
    }
}

// MARK: - Sponsored Product
struct SponsoredProduct: Decodable {
    let id: Int
    let title: String
    let image: String
    let price: Double
    let instantDiscountPrice: Double?
    let rate: Double?
}

// MARK: - Product
struct Product: Decodable {
    let id: Int
    let title: String
    let image: String
    let price: Double
    let instantDiscountPrice: Double?
    let rate: Double?
    let sellerName: String?
}
