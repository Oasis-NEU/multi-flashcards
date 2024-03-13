//
//  APIError.swift
//  multi-flashcards
//
//  Created by Peyton McKee on 3/12/24.
//

import Foundation

enum APIError: Error {
    case invalidResponseCode(Int, Data? = nil)
    case cardMustHaveIdFor(operation: String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponseCode(let code, let data):
            if let data = data, let string = String(data: data, encoding: .utf8) {
                return "Invalid response code: \(code). Response: \(string)"
            } else {
                return "Invalid response code: \(code)"
            }
        case .cardMustHaveIdFor(let operation):
            return "Card must have an ID to \(operation)"
        }
    }
}
