//
//  Model.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import Foundation

protocol Model: Decodable {
    static var decoder: JSONDecoder { get }
}

extension Model {
     static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension Array: Model where Element: Model {
    static var decoder: JSONDecoder {
        Element.decoder
    }
}
