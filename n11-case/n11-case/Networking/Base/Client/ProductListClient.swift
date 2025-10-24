//
//  ProductListClient.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import Foundation

protocol ProductListClientProtocol: AnyObject {
    
    func get(path: String, queryItems: [URLQueryItem]?) async -> Result<ProductListResponse<Product>, APIError>
}

final class ProductListClient: ProductListClientProtocol {
    
    var api: APIClient = {
        let configuration = URLSessionConfiguration.default
        return APIClient(configuration: configuration)
    }()
    
    
    init(api: APIClient = APIClient()) {
        self.api = api
    }
    
    func get(path: String, queryItems: [URLQueryItem]? = nil) async -> Result<ProductListResponse<Product>, APIError> {
        let response = await api.send(Request.get(path: path, queryItems: queryItems))
        let decodedResponse = await response.decoding(ProductListResponse<Product>.self)
        switch decodedResponse {
        case .success(let success):
            return .success(success)
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
