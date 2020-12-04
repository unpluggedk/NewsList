//
//  APIError.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case httpCode(Int)
    case unexpected(Error?)
    case cancelled
}

