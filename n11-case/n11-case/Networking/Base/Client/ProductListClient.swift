//
//  ProductListClient.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import Foundation

protocol ProductListClientProtocol: AnyObject {
    func get(path: String, queryItems: [URLQueryItem]?) async -> Result<ProductListResponse, APIError>
}

final class ProductListClient: ProductListClientProtocol {
    
    var decoder: JSONDecoder
    var api: APIClient = {
        let configuration = URLSessionConfiguration.default
        return APIClient(configuration: configuration)
    }()
    
    
    init(api: APIClient = APIClient()) {
        self.api = api
        decoder = JSONDecoder()
    }
    
    func get(path: String, queryItems: [URLQueryItem]? = nil) async -> Result<ProductListResponse, APIError> {
        do {
            let response = await api.send(Request.get(path: path, queryItems: queryItems))
            let decodedResponse = try decoder.decode(ProductListResponse.self, from: response.get())
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
