//
//  ClientErrors.swift
//  PocViewCode
//
//  Created by Felipe Assis on 04/12/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case apiError
    case decodeError
}
