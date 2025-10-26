//
//  ProductDetailClient.swift
//  n11-case
//
//  Created by Tolga Taner on 25.10.2025.
//

import Foundation

protocol ProductDetailClientProtocol: AnyObject {
    func get(path: String, queryItems: [URLQueryItem]?) async -> Result<ProductDetailResponse, APIError>
}

final class ProductDetailClient: ProductDetailClientProtocol {
    
    var decoder: JSONDecoder
    var api: APIClient = {
        let configuration = URLSessionConfiguration.default
        return APIClient(configuration: configuration)
    }()
    
    
    init(api: APIClient = APIClient()) {
        self.api = api
        decoder = JSONDecoder()
    }
    
    func get(path: String, queryItems: [URLQueryItem]? = nil) async -> Result<ProductDetailResponse, APIError> {
        do {
            let response = await api.send(Request.get(path: path, queryItems: queryItems))
            let decodedResponse = try decoder.decode(ProductDetailResponse.self, from: response.get())
            return .success(decodedResponse)
        }
        catch(let error as APIError) {
            return .failure(error)
         }
        catch {
            return .failure(.unhandledResponse)
        }
    }
}
