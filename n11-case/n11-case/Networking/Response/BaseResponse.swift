//
//  BaseResponse.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import Foundation

struct BaseResponse<T: Model>: Model {
    let status: String
    let data: T
}
