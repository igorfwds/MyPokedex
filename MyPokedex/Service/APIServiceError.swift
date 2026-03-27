//
//  APIServiceError.swift
//  MyPokedex
//
//  Created by Igor Wanderley on 23/03/26.
//

import Foundation

enum APIServiceError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case statusError
}
