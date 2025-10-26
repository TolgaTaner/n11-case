import Foundation

struct ProductListResponse: Decodable {
    let page, publishedAt: String
    let nextPage: String?
    let sponsoredProducts: [SponsoredProduct]?
    let products: [ListedProduct]

    enum CodingKeys: String, CodingKey {
        case page, nextPage
        case publishedAt = "published_at"
        case sponsoredProducts, products
    }
}

// MARK: - Sponsored Product
protocol Product {
    var id: Int { get }
    var title: String { get }
    var image: String { get }
    var price: Double { get }
    var instantDiscountPrice: Double? { get }
    var rate: Double? { get }
}
struct SponsoredProduct: Decodable, Product {
    var id: Int
    var title: String
    var image: String
    var price: Double
    var instantDiscountPrice: Double?
    var rate: Double?
}

// MARK: - Product
struct ListedProduct: Decodable, Product {
    var id: Int
    var title: String
    var image: String
    var price: Double
    var instantDiscountPrice: Double?
    var rate: Double?
    let sellerName: String?
}
