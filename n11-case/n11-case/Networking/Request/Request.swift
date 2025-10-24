//
//  Request.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import Foundation

struct Request {
    let builder: RequestBuilder
    
    init(builder: RequestBuilder) {
        self.builder = builder
    }
    
    static func get(method: HTTPMethod = .get,
                    path: String,
                    queryItems: [URLQueryItem]?) -> Request {
        let builder = GetRequestBuilder(method: method,
                                        endpoint: Endpoint(path: path,
                                                           queryItems: queryItems ?? nil))
        return Request(builder: builder)
    }
    
}
